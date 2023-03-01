{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2uidationeventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevent_2uidationeventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    posteddate,
    liquidationfeeamount,
    originalremovalorderid,
    liquidationproceedsamount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_fbaliquidationeventlist_hashid
from {{ ref('au_listfinancialevent_2uidationeventlist_ab3') }}
-- fbaliquidationeventlist at AU_ListFinancialEvents/FBALiquidationEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

