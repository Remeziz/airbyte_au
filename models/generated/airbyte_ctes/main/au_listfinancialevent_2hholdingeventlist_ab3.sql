{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2hholdingeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('baseamount'),
        'posteddate',
        object_to_string('withheldamount'),
        object_to_string('taxwithholdingperiod'),
    ]) }} as _airbyte_taxwithholdingeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2hholdingeventlist_ab2') }} tmp
-- taxwithholdingeventlist at AU_ListFinancialEvents/TaxWithholdingEventList
where 1 = 1

