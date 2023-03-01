{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2ervicingeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        object_to_string('loanamount'),
        'sourcebusinesseventtype',
    ]) }} as _airbyte_loanservicingeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2ervicingeventlist_ab2') }} tmp
-- loanservicingeventlist at AU_ListFinancialEvents/LoanServicingEventList
where 1 = 1

