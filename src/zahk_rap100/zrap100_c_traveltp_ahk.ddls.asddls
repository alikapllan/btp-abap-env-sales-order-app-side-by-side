@AccessControl.authorizationCheck: #MANDATORY

@EndUserText.label: '###GENERATED Core Data Service Entity'

@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'ZAHK_RAP100_ATRV'

@Search.searchable: true

define root view entity ZRAP100_C_TRAVELTP_AHK
  provider contract transactional_query
  as projection on ZRAP100_R_TRAVELTP_AHK

  association [1..1] to ZRAP100_R_TRAVELTP_AHK as _BaseEntity on $projection.TravelID = _BaseEntity.TravelID

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
  key TravelID,

      @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Agency', element: 'AgencyID' },
                                            useForValidation: true } ]
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Search.defaultSearchElement: true

      AgencyID,

      _Agency.Name              as AgencyName,

      @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Customer', element: 'CustomerID' },
                                            useForValidation: true } ]
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Search.defaultSearchElement: true

      CustomerID,

      _Customer.LastName        as CustomerName,
      BeginDate,
      EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      @Consumption.valueHelpDefinition: [ { entity: { element: 'Currency', name: 'I_CurrencyStdVH' },
                                            useForValidation: true } ]
      CurrencyCode,

      Description,

      @Consumption.valueHelpDefinition: [ { entity: { element: 'OverallStatus', name: '/DMO/I_Overall_Status_VH' },
                                            useForValidation: true } ]
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      OverallStatus,

      _OverallStatus._Text.Text as OverallStatusText : localized,
      Attachment,
      MimeType,
      FileName,

      @Semantics.user.createdBy: true
      CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      CreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      _BaseEntity
}
