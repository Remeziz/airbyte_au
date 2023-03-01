{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2lpaymenteventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevent_2lpaymenteventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    dealid,
    feetype,
    eventtype,
    feeamount,
    taxamount,
    posteddate,
    totalamount,
    dealdescription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sellerdealpaymenteventlist_hashid
from {{ ref('au_listfinancialevent_2lpaymenteventlist_ab3') }}
-- sellerdealpaymenteventlist at AU_ListFinancialEvents/SellerDealPaymentEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

