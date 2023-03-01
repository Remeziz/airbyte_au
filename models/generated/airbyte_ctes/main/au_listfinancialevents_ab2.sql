{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevents_ab1') }}
select
    refundeventlist,
    shipmenteventlist,
    adjustmenteventlist,
    chargebackeventlist,
    servicefeeeventlist,
    retrochargeeventlist,
    debtrecoveryeventlist,
    couponpaymenteventlist,
    loanservicingeventlist,
    paywithamazoneventlist,
    trialshipmenteventlist,
    fbaliquidationeventlist,
    guaranteeclaimeventlist,
    shipmentsettleeventlist,
    taxwithholdingeventlist,
    removalshipmenteventlist,
    productadspaymenteventlist,
    rentaltransactioneventlist,
    sellerdealpaymenteventlist,
    imagingservicesfeeeventlist,
    safetreimbursementeventlist,
    affordabilityexpenseeventlist,
    serviceprovidercrediteventlist,
    removalshipmentadjustmenteventlist,
    affordabilityexpensereversaleventlist,
    networkcomminglingtransactioneventlist,
    sellerreviewenrollmentpaymenteventlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents_ab1') }}
-- au_listfinancialevents
where 1 = 1

