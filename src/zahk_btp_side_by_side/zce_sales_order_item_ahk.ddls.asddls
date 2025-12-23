@EndUserText.label: 'Custom entity for Sales Order Items'

@Metadata.allowExtensions: true

@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_SALES_ORDER_AHK'
define custom entity ZCE_SALES_ORDER_ITEM_AHK

{
  key SalesOrder              : abap.char(10);
  key SalesOrderItem          : abap.char(6);

      Material                : abap.char(40);

      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      RequestedQuantity       : abap.quan(15,3);

      RequestedQuantityUnit   : abap.unit(3);

      // Association to parent header
      _SalesOrder             : association to parent ZCE_SALES_ORDER_AHK on $projection.SalesOrder = _SalesOrder.SalesOrder;
}

