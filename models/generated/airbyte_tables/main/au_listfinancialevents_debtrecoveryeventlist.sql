{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevent_2recoveryeventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevent_2recoveryeventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    recoveryamount,
    debtrecoverytype,
    overpaymentcredit,
    chargeinstrumentlist,
    debtrecoveryitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_debtrecoveryeventlist_hashid
from {{ ref('au_listfinancialevent_2recoveryeventlist_ab3') }}
-- debtrecoveryeventlist at AU_ListFinancialEvents/DebtRecoveryEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

