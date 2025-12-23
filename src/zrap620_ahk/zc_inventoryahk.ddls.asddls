@AccessControl.authorizationCheck: #MANDATORY

@EndUserText.label: '###GENERATED Core Data Service Entity'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'ZInventoryAHK'

define root view entity ZC_INVENTORYAHK
  provider contract transactional_query
  as projection on ZR_INVENTORYAHK

  association [1..1] to ZR_INVENTORYAHK as _BaseEntity on $projection.UUID = _BaseEntity.UUID

{
  key UUID,

      InventoryID,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZCE_PRODUCTS_AHK', element: 'Product' },
                                            useForValidation: true } ]
      ProductID,

      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      Quantity,

      @Consumption.valueHelpDefinition: [ { entity: { element: 'UnitOfMeasure', name: 'I_UnitOfMeasureStdVH' },
                                            useForValidation: true } ]
      QuantityUnit,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,

      @Consumption.valueHelpDefinition: [ { entity: { element: 'Currency', name: 'I_CurrencyStdVH' },
                                            useForValidation: true } ]
      CurrencyCode,

      Description,
      OverallStatus,

      @Semantics.user.createdBy: true
      LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      _BaseEntity
}
