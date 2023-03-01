{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2npaymenteventlist_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_listfinancialevent_2npaymenteventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    couponid,
    posteddate,
    totalamount,
    feecomponent,
    paymenteventid,
    chargecomponent,
    cliporredemptioncount,
    sellercoupondescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_couponpaymenteventlist_hashid
from {{ ref('au_listfinancialevent_2npaymenteventlist_ab3') }}
-- couponpaymenteventlist at AU_ListFinancialEvents/CouponPaymentEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

