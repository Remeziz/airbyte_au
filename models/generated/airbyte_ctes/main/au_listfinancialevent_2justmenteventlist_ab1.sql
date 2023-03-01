{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'removalshipmentadjustmenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('removalshipmentadjustmenteventlist'), ['OrderId'], ['OrderId']) }} as orderid,
    {{ json_extract_scalar(unnested_column_value('removalshipmentadjustmenteventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('removalshipmentadjustmenteventlist'), ['MerchantOrderId'], ['MerchantOrderId']) }} as merchantorderid,
    {{ json_extract_scalar(unnested_column_value('removalshipmentadjustmenteventlist'), ['TransactionType'], ['TransactionType']) }} as transactiontype,
    {{ json_extract_scalar(unnested_column_value('removalshipmentadjustmenteventlist'), ['AdjustmentEventId'], ['AdjustmentEventId']) }} as adjustmenteventid,
    {{ json_extract_array(unnested_column_value('removalshipmentadjustmenteventlist'), ['RemovalShipmentItemAdjustmentList'], ['RemovalShipmentItemAdjustmentList']) }} as removalshipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- removalshipmentadjustmenteventlist at AU_ListFinancialEvents/RemovalShipmentAdjustmentEventList
{{ cross_join_unnest('au_listfinancialevents', 'removalshipmentadjustmenteventlist') }}
where 1 = 1
and removalshipmentadjustmenteventlist is not null

