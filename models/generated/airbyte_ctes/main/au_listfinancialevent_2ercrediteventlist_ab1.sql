{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('au_listfinancialevents') }}
{{ unnest_cte(ref('au_listfinancialevents'), 'au_listfinancialevents', 'serviceprovidercrediteventlist') }}
select
    _airbyte_au_listfinancialevents_hashid,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['SellerId'], ['SellerId']) }} as sellerid,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['ProviderId'], ['ProviderId']) }} as providerid,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['MarketplaceId'], ['MarketplaceId']) }} as marketplaceid,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['SellerOrderId'], ['SellerOrderId']) }} as sellerorderid,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['SellerStoreName'], ['SellerStoreName']) }} as sellerstorename,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['ProviderStoreName'], ['ProviderStoreName']) }} as providerstorename,
    {{ json_extract('', unnested_column_value('serviceprovidercrediteventlist'), ['TransactionAmount'], ['TransactionAmount']) }} as transactionamount,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['MarketplaceCountryCode'], ['MarketplaceCountryCode']) }} as marketplacecountrycode,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['ProviderTransactionType'], ['ProviderTransactionType']) }} as providertransactiontype,
    {{ json_extract_scalar(unnested_column_value('serviceprovidercrediteventlist'), ['TransactionCreationDate'], ['TransactionCreationDate']) }} as transactioncreationdate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevents') }} as table_alias
-- serviceprovidercrediteventlist at AU_ListFinancialEvents/ServiceProviderCreditEventList
{{ cross_join_unnest('au_listfinancialevents', 'serviceprovidercrediteventlist') }}
where 1 = 1
and serviceprovidercrediteventlist is not null

