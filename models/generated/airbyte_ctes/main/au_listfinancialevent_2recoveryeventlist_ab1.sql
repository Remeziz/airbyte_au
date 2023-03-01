{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'debtrecoveryeventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('debtrecoveryeventlist'), ['RecoveryAmount'], ['RecoveryAmount']) }} as recoveryamount,
    {{ json_extract_scalar(unnested_column_value('debtrecoveryeventlist'), ['DebtRecoveryType'], ['DebtRecoveryType']) }} as debtrecoverytype,
    {{ json_extract('', unnested_column_value('debtrecoveryeventlist'), ['OverPaymentCredit'], ['OverPaymentCredit']) }} as overpaymentcredit,
    {{ json_extract_array(unnested_column_value('debtrecoveryeventlist'), ['ChargeInstrumentList'], ['ChargeInstrumentList']) }} as chargeinstrumentlist,
    {{ json_extract_array(unnested_column_value('debtrecoveryeventlist'), ['DebtRecoveryItemList'], ['DebtRecoveryItemList']) }} as debtrecoveryitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- debtrecoveryeventlist at AU_ListFinancialEvents/DebtRecoveryEventList
{{ cross_join_unnest('au_listfinancialevents', 'debtrecoveryeventlist') }}
where 1 = 1
and debtrecoveryeventlist is not null

