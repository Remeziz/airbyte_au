{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2rvicefeeeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'asin',
        'fnsku',
        array_to_string('feelist'),
        'feereason',
        'sellersku',
        'amazonorderid',
        'feedescription',
    ]) }} as _airbyte_servicefeeeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2rvicefeeeventlist_ab2') }} tmp
-- servicefeeeventlist at AU_ListFinancialEvents/ServiceFeeEventList
where 1 = 1

