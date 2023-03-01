{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_get_sales_and_traffic_report_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'childasin',
        'parentasin',
        object_to_string('salesbyasin'),
        'queryenddate',
        object_to_string('trafficbyasin'),
    ]) }} as _airbyte_au_get_sales__traffic_report_hashid,
    tmp.*
from {{ ref('au_get_sales_and_traffic_report_ab2') }} tmp
-- au_get_sales_and_traffic_report
where 1 = 1

