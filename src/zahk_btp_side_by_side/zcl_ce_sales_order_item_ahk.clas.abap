CLASS zcl_ce_sales_order_item_ahk DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
    " for test
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_ce_sales_order_item_ahk IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA lo_http_client        TYPE REF TO if_web_http_client.
    DATA lo_client_proxy       TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_read_list_request  TYPE REF TO /iwbep/if_cp_request_read_list.
    DATA lo_read_list_response TYPE REF TO /iwbep/if_cp_response_read_lst.
    DATA lt_business_data      TYPE TABLE OF zsc_test_api_sales_order_srv=>tys_a_sales_order_item_type.
    DATA lt_sales_order_items  TYPE TABLE OF zce_sales_order_item_ahk.
    DATA ls_sales_order_item   TYPE zce_sales_order_item_ahk.
    DATA lv_error_message      TYPE string.

    TRY.
        IF io_request->is_data_requested( ).

          " Create HTTP client via communication arrangement
          DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                     comm_scenario  = 'ZBTP_TRIAL_SAP_COM_0109'
                                     comm_system_id = 'ZBTP_TRIAL_SAP_COM_0109'
                                     service_id     = 'ZBTP_TRIAL_SAP_COM_0109_REST' ).

          lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

          lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
              is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                  proxy_model_id      = 'ZSCM_TEST_API_SALES_ORDER_SRV'
                                                  proxy_model_version = '0001' )
              io_http_client           = lo_http_client
              iv_relative_service_root = '' ).

          " Create read list request for sales order items
          lo_read_list_request = lo_client_proxy->create_resource_for_entity_set( 'A_SALES_ORDER_ITEM' )->create_request_for_read( ).

          " Sort by SalesOrder descending to get items from latest orders first
          lo_read_list_request->set_orderby( VALUE #( ( property_path = 'SALES_ORDER' descending = abap_true )
                                                      ( property_path = 'SALES_ORDER_ITEM' descending = abap_false ) ) ).

          " Apply paging if requested
          DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
          DATA(lv_skip) = io_request->get_paging( )->get_offset( ).

          IF lv_top > 0.
            lo_read_list_request->set_top( CONV #( lv_top ) ).
          ENDIF.

          IF lv_skip > 0.
            lo_read_list_request->set_skip( CONV #( lv_skip ) ).
          ENDIF.

          " Execute the request
          lo_read_list_response = lo_read_list_request->execute( ).

          " Get business data
          lo_read_list_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

          " Map API response to custom entity structure
          LOOP AT lt_business_data INTO DATA(ls_api_data).
            ls_sales_order_item = CORRESPONDING #( ls_api_data MAPPING
              SalesOrder = sales_order
              SalesOrderItem = sales_order_item
              Material = material
              RequestedQuantity = requested_quantity
              RequestedQuantityUnit = requested_quantity_unit ).
            APPEND ls_sales_order_item TO lt_sales_order_items.
          ENDLOOP.

          " Set total count if requested
          IF io_request->is_total_numb_of_rec_requested( ).
            io_response->set_total_number_of_records( lines( lt_sales_order_items ) ).
          ENDIF.

          " Set response data
          io_response->set_data( lt_sales_order_items ).

        ENDIF.

      CATCH cx_web_http_client_error INTO DATA(lx_http).
        lv_error_message = |HTTP client error: { lx_http->get_text( ) }|.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        lv_error_message = |Remote error: { lx_remote->get_text( ) }|.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        lv_error_message = |Gateway error: { lx_gateway->get_text( ) }|.

      CATCH cx_http_dest_provider_error INTO DATA(lx_dest_error).
        lv_error_message = |Destination error: { lx_dest_error->get_text( ) }|.

    ENDTRY.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    DATA lo_http_client        TYPE REF TO if_web_http_client.
    DATA lo_client_proxy       TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_read_list_request  TYPE REF TO /iwbep/if_cp_request_read_list.
    DATA lo_read_list_response TYPE REF TO /iwbep/if_cp_response_read_lst.
    DATA lt_business_data      TYPE TABLE OF zsc_test_api_sales_order_srv=>tys_a_sales_order_item_type.

    TRY.
        " Create HTTP client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                   comm_scenario  = 'ZBTP_TRIAL_SAP_COM_0109'
                                   comm_system_id = 'ZBTP_TRIAL_SAP_COM_0109'
                                   service_id     = 'ZBTP_TRIAL_SAP_COM_0109_REST' ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                              is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                                  proxy_model_id      = 'ZSCM_TEST_API_SALES_ORDER_SRV'
                                                                  proxy_model_version = '0001' )
                              io_http_client           = lo_http_client
                              iv_relative_service_root = '' ).

        " Create read request
        lo_read_list_request = lo_client_proxy->create_resource_for_entity_set( 'A_SALES_ORDER_ITEM' )->create_request_for_read( ).

        " Set order by sales order descending, then item ascending
        lo_read_list_request->set_orderby( VALUE #( ( property_path = 'SALES_ORDER' descending = abap_true )
                                                    ( property_path = 'SALES_ORDER_ITEM' descending = abap_false ) ) ).

        " Set top 10
        lo_read_list_request->set_top( 10 ).

        " Execute request
        lo_read_list_response = lo_read_list_request->execute( ).

        " Get business data
        lo_read_list_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

        " Display results
        IF lt_business_data IS NOT INITIAL.
          out->write( |Found { lines( lt_business_data ) } sales order items from latest orders| ).
          LOOP AT lt_business_data INTO DATA(ls_item).
            out->write(
                |Order: { ls_item-sales_order }, Item: { ls_item-sales_order_item }, Material: { ls_item-material }, Qty: { ls_item-requested_quantity } { ls_item-requested_quantity_unit }| ).
          ENDLOOP.
        ELSE.
          out->write( 'No sales order items found' ).
        ENDIF.
      CATCH cx_web_http_client_error INTO DATA(lx_http).
        out->write( |HTTP client error: { lx_http->get_text( ) }| ).
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        out->write( |Remote error: { lx_remote->get_text( ) }| ).
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        out->write( |Gateway error: { lx_gateway->get_text( ) }| ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_dest_error).
        out->write( |Destination error: { lx_dest_error->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
