{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevents_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_listfinancialevents_ab3') }}
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
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_au_listfinancialevents_hashid
from {{ ref('au_listfinancialevents_ab3') }}
-- au_listfinancialevents from {{ source('main', '_airbyte_raw_au_listfinancialevents') }}
where 1 = 1

