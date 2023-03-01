{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('au_listfinancialevent_2hholdingeventlist_ab1') }}
select
    _airbyte_au_listfinancialevents_hashid,
    cast(baseamount as {{ type_json() }}) as baseamount,
    cast({{ empty_string_to_null('posteddate') }} as {{ type_timestamp_with_timezone() }}) as posteddate,
    cast(withheldamount as {{ type_json() }}) as withheldamount,
    cast(taxwithholdingperiod as {{ type_json() }}) as taxwithholdingperiod,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('au_listfinancialevent_2hholdingeventlist_ab1') }}
-- taxwithholdingeventlist at AU_ListFinancialEvents/TaxWithholdingEventList
where 1 = 1

