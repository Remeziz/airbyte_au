{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2reversaleventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'posteddate',
        object_to_string('baseexpense'),
        object_to_string('taxtypecgst'),
        object_to_string('taxtypeigst'),
        object_to_string('taxtypesgst'),
        object_to_string('totalexpense'),
        'amazonorderid',
        'marketplaceid',
        'transactiontype',
    ]) }} as _airbyte_affordabilit__ersaleventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2reversaleventlist_ab2') }} tmp
-- affordabilityexpensereversaleventlist at AU_ListFinancialEvents/AffordabilityExpenseReversalEventList
where 1 = 1

