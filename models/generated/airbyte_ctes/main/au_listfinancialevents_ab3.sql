{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevents_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('refundeventlist'),
        array_to_string('shipmenteventlist'),
        array_to_string('adjustmenteventlist'),
        array_to_string('chargebackeventlist'),
        array_to_string('servicefeeeventlist'),
        array_to_string('retrochargeeventlist'),
        array_to_string('debtrecoveryeventlist'),
        array_to_string('couponpaymenteventlist'),
        array_to_string('loanservicingeventlist'),
        array_to_string('paywithamazoneventlist'),
        array_to_string('trialshipmenteventlist'),
        array_to_string('fbaliquidationeventlist'),
        array_to_string('guaranteeclaimeventlist'),
        array_to_string('shipmentsettleeventlist'),
        array_to_string('taxwithholdingeventlist'),
        array_to_string('removalshipmenteventlist'),
        array_to_string('productadspaymenteventlist'),
        array_to_string('rentaltransactioneventlist'),
        array_to_string('sellerdealpaymenteventlist'),
        array_to_string('imagingservicesfeeeventlist'),
        array_to_string('safetreimbursementeventlist'),
        array_to_string('affordabilityexpenseeventlist'),
        array_to_string('serviceprovidercrediteventlist'),
        array_to_string('removalshipmentadjustmenteventlist'),
        array_to_string('affordabilityexpensereversaleventlist'),
        array_to_string('networkcomminglingtransactioneventlist'),
        array_to_string('sellerreviewenrollmentpaymenteventlist'),
    ]) }} as _airbyte_au_listfinancialevents_hashid,
    tmp.*
from {{ ref('au_listfinancialevents_ab2') }} tmp
-- au_listfinancialevents
where 1 = 1

