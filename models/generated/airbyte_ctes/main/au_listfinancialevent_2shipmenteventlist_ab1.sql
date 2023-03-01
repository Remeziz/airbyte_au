{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'removalshipmenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('removalshipmenteventlist'), ['OrderId'], ['OrderId']) }} as orderid,
    {{ json_extract_scalar(unnested_column_value('removalshipmenteventlist'), ['PostedDate'], ['PostedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('removalshipmenteventlist'), ['MerchantOrderId'], ['MerchantOrderId']) }} as merchantorderid,
    {{ json_extract_scalar(unnested_column_value('removalshipmenteventlist'), ['TransactionType'], ['TransactionType']) }} as transactiontype,
    {{ json_extract_array(unnested_column_value('removalshipmenteventlist'), ['RemovalShipmentItemList'], ['RemovalShipmentItemList']) }} as removalshipmentitemlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- removalshipmenteventlist at AU_ListFinancialEvents/RemovalShipmentEventList
{{ cross_join_unnest('au_listfinancialevents', 'removalshipmenteventlist') }}
where 1 = 1
and removalshipmenteventlist is not null

