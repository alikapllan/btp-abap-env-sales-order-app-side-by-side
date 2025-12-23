CLASS lhc_ZCE_SALES_ORDER_AHK DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zce_sales_order_ahk RESULT result.

*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR zce_sales_order_ahk RESULT result.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE zce_sales_order_ahk.

    METHODS read FOR READ
      IMPORTING keys FOR READ zce_sales_order_ahk RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zce_sales_order_ahk.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zce_sales_order_ahk RESULT result.

    METHODS createsalesorderwithitem FOR MODIFY
      IMPORTING keys FOR ACTION zce_sales_order_ahk~createsalesorderwithitem.

    METHODS getdefaultsforpopup FOR READ
      IMPORTING keys FOR FUNCTION zce_sales_order_ahk~getdefaultsforpopup RESULT result.

ENDCLASS.


CLASS lhc_ZCE_SALES_ORDER_AHK IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

*  METHOD create.
*  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CreateSalesOrderWithItem.
  ENDMETHOD.

  METHOD GetDefaultsForPopup.
    " source : https://software-heroes.com/en/blog/abap-rap-popup-default-values
    LOOP AT keys INTO DATA(key).
      INSERT VALUE #( %cid = key-%cid ) INTO TABLE result REFERENCE INTO DATA(new_line).

      new_line->%param = VALUE z_i_sales_order_create_act(
                                   SalesOrderType        = 'OR'
                                   SalesOrganization     = '1710'
                                   DistributionChannel   = '10'
                                   OrganizationDivision  = '00'
                                   SalesDistrict         = 'US0003'
                                   SoldToParty           = 'USCU_L04'
                                   RequestedDeliveryDate = cl_abap_context_info=>get_system_date( )
                                   RequestedQuantityUnit = 'PC' ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.


CLASS lsc_ZCE_SALES_ORDER_AHK DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save              REDEFINITION.

    METHODS cleanup           REDEFINITION.

    METHODS cleanup_finalize  REDEFINITION.

ENDCLASS.


CLASS lsc_ZCE_SALES_ORDER_AHK IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
