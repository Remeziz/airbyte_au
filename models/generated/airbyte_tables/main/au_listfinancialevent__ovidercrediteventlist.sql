{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2ercrediteventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevent_2ercrediteventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    sellerid,
    providerid,
    marketplaceid,
    sellerorderid,
    sellerstorename,
    providerstorename,
    transactionamount,
    marketplacecountrycode,
    providertransactiontype,
    transactioncreationdate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_serviceprovi__rediteventlist_hashid
from {{ ref('au_listfinancialevent_2ercrediteventlist_ab3') }}
-- serviceprovidercrediteventlist at AU_ListFinancialEvents/ServiceProviderCreditEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

