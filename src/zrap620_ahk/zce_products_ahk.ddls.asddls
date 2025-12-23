@EndUserText.label: 'Custom entity for products from S4'

@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_PRODUCTS_AHK'
define custom entity ZCE_PRODUCTS_AHK

// with parameters parameter_name : parameter_type
{
  key Product             : abap.char(40);

      // Property name must not be ProductType 
      ProductTypeName         : abap.char(4);
      ProductGroupName        : abap.char(9);
}
