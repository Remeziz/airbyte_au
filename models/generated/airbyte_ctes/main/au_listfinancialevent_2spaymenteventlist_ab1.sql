{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'productadspaymenteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract('', unnested_column_value('productadspaymenteventlist'), ['taxValue'], ['taxValue']) }} as taxvalue,
    {{ json_extract('', unnested_column_value('productadspaymenteventlist'), ['baseValue'], ['baseValue']) }} as basevalue,
    {{ json_extract_scalar(unnested_column_value('productadspaymenteventlist'), ['invoiceId'], ['invoiceId']) }} as invoiceid,
    {{ json_extract_scalar(unnested_column_value('productadspaymenteventlist'), ['postedDate'], ['postedDate']) }} as posteddate,
    {{ json_extract_scalar(unnested_column_value('productadspaymenteventlist'), ['transactionType'], ['transactionType']) }} as transactiontype,
    {{ json_extract('', unnested_column_value('productadspaymenteventlist'), ['transactionValue'], ['transactionValue']) }} as transactionvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- productadspaymenteventlist at AU_ListFinancialEvents/ProductAdsPaymentEventList
{{ cross_join_unnest('au_listfinancialevents', 'productadspaymenteventlist') }}
where 1 = 1
and productadspaymenteventlist is not null

