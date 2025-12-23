CLASS lhc_zr_inventoryahk DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
              IMPORTING
                 REQUEST requested_authorizations FOR Inventory
              RESULT result.
    METHODS CalculateInventoryID FOR DETERMINE ON SAVE
                  IMPORTING keys FOR Inventory~CalculateInventoryID.
ENDCLASS.


CLASS lhc_zr_inventoryahk IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CalculateInventoryID.
    " Ensure idempotence
    READ ENTITIES OF zr_inventoryahk IN LOCAL MODE
         ENTITY Inventory
         FIELDS ( InventoryID )
         WITH CORRESPONDING #( keys )
         RESULT DATA(inventories).

    DELETE inventories WHERE InventoryID IS NOT INITIAL.

    IF inventories IS INITIAL.
      RETURN.
    ENDIF.

    " Get max travelID
    SELECT SINGLE FROM zr_inventoryahk
      FIELDS MAX( inventoryid )
      INTO @DATA(max_inventory).

    " update involved instances
    MODIFY ENTITIES OF zr_inventoryahk IN LOCAL MODE
           ENTITY Inventory
           UPDATE FIELDS ( InventoryID )
           WITH VALUE #( FOR inventory IN inventories INDEX INTO i
                         ( %tky        = inventory-%tky
                           inventoryID = max_inventory + i ) )
           REPORTED DATA(update_reported).

    " fill reported
    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.
ENDCLASS.
