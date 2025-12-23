@EndUserText.label: 'Value Help Custom entity for Sales Order'

@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_VH_SALES_ORDER_AHK'

define custom entity zce_vh_sales_order_ahk

{
  key SalesOrder           : abap.char(10);

      CreationDate         : abap.dats;
      CreatedByUser        : abap.char(12);
}
