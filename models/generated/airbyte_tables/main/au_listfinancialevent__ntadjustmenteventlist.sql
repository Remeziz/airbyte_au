{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2justmenteventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevent_2justmenteventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    orderid,
    posteddate,
    merchantorderid,
    transactiontype,
    adjustmenteventid,
    removalshipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_removalshipm__tmenteventlist_hashid
from {{ ref('au_listfinancialevent_2justmenteventlist_ab3') }}
-- removalshipmentadjustmenteventlist at AU_ListFinancialEvents/RemovalShipmentAdjustmentEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

