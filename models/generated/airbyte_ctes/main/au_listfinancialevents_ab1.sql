{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_au_listfinancialevents') }}
select
    {{ json_extract_array('_airbyte_data', ['RefundEventList'], ['RefundEventList']) }} as refundeventlist,
    {{ json_extract_array('_airbyte_data', ['ShipmentEventList'], ['ShipmentEventList']) }} as shipmenteventlist,
    {{ json_extract_array('_airbyte_data', ['AdjustmentEventList'], ['AdjustmentEventList']) }} as adjustmenteventlist,
    {{ json_extract_array('_airbyte_data', ['ChargebackEventList'], ['ChargebackEventList']) }} as chargebackeventlist,
    {{ json_extract_array('_airbyte_data', ['ServiceFeeEventList'], ['ServiceFeeEventList']) }} as servicefeeeventlist,
    {{ json_extract_array('_airbyte_data', ['RetrochargeEventList'], ['RetrochargeEventList']) }} as retrochargeeventlist,
    {{ json_extract_array('_airbyte_data', ['DebtRecoveryEventList'], ['DebtRecoveryEventList']) }} as debtrecoveryeventlist,
    {{ json_extract_array('_airbyte_data', ['CouponPaymentEventList'], ['CouponPaymentEventList']) }} as couponpaymenteventlist,
    {{ json_extract_array('_airbyte_data', ['LoanServicingEventList'], ['LoanServicingEventList']) }} as loanservicingeventlist,
    {{ json_extract_array('_airbyte_data', ['PayWithAmazonEventList'], ['PayWithAmazonEventList']) }} as paywithamazoneventlist,
    {{ json_extract_array('_airbyte_data', ['TrialShipmentEventList'], ['TrialShipmentEventList']) }} as trialshipmenteventlist,
    {{ json_extract_array('_airbyte_data', ['FBALiquidationEventList'], ['FBALiquidationEventList']) }} as fbaliquidationeventlist,
    {{ json_extract_array('_airbyte_data', ['GuaranteeClaimEventList'], ['GuaranteeClaimEventList']) }} as guaranteeclaimeventlist,
    {{ json_extract_array('_airbyte_data', ['ShipmentSettleEventList'], ['ShipmentSettleEventList']) }} as shipmentsettleeventlist,
    {{ json_extract_array('_airbyte_data', ['TaxWithholdingEventList'], ['TaxWithholdingEventList']) }} as taxwithholdingeventlist,
    {{ json_extract_array('_airbyte_data', ['RemovalShipmentEventList'], ['RemovalShipmentEventList']) }} as removalshipmenteventlist,
    {{ json_extract_array('_airbyte_data', ['ProductAdsPaymentEventList'], ['ProductAdsPaymentEventList']) }} as productadspaymenteventlist,
    {{ json_extract_array('_airbyte_data', ['RentalTransactionEventList'], ['RentalTransactionEventList']) }} as rentaltransactioneventlist,
    {{ json_extract_array('_airbyte_data', ['SellerDealPaymentEventList'], ['SellerDealPaymentEventList']) }} as sellerdealpaymenteventlist,
    {{ json_extract_array('_airbyte_data', ['ImagingServicesFeeEventList'], ['ImagingServicesFeeEventList']) }} as imagingservicesfeeeventlist,
    {{ json_extract_array('_airbyte_data', ['SAFETReimbursementEventList'], ['SAFETReimbursementEventList']) }} as safetreimbursementeventlist,
    {{ json_extract_array('_airbyte_data', ['AffordabilityExpenseEventList'], ['AffordabilityExpenseEventList']) }} as affordabilityexpenseeventlist,
    {{ json_extract_array('_airbyte_data', ['ServiceProviderCreditEventList'], ['ServiceProviderCreditEventList']) }} as serviceprovidercrediteventlist,
    {{ json_extract_array('_airbyte_data', ['RemovalShipmentAdjustmentEventList'], ['RemovalShipmentAdjustmentEventList']) }} as removalshipmentadjustmenteventlist,
    {{ json_extract_array('_airbyte_data', ['AffordabilityExpenseReversalEventList'], ['AffordabilityExpenseReversalEventList']) }} as affordabilityexpensereversaleventlist,
    {{ json_extract_array('_airbyte_data', ['NetworkComminglingTransactionEventList'], ['NetworkComminglingTransactionEventList']) }} as networkcomminglingtransactioneventlist,
    {{ json_extract_array('_airbyte_data', ['SellerReviewEnrollmentPaymentEventList'], ['SellerReviewEnrollmentPaymentEventList']) }} as sellerreviewenrollmentpaymenteventlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_au_listfinancialevents') }} as table_alias
-- au_listfinancialevents
where 1 = 1

