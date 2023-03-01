{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_listfinancialevent_2vicesfeeeventlist_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_listfinancialevents_hashid',
        'asin',
        array_to_string('feelist'),
        'posteddate',
        'imagingrequestbillingitemid',
    ]) }} as _airbyte_imagingservicesfeeeventlist_hashid,
    tmp.*
from {{ ref('au_listfinancialevent_2vicesfeeeventlist_ab2') }} tmp
-- imagingservicesfeeeventlist at AU_ListFinancialEvents/ImagingServicesFeeEventList
where 1 = 1

