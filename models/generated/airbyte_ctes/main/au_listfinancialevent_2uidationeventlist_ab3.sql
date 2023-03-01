{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2uidationeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'posteddate',
        object_to_string('liquidationfeeamount'),
        'originalremovalorderid',
        object_to_string('liquidationproceedsamount'),
    ]) }} as _airbyte_fbaliquidationeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2uidationeventlist_ab2') }} tmp
-- fbaliquidationeventlist at AU_ListFinancialEvents/FBALiquidationEventList
where 1 = 1

