{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_get_sales_and_traf_2eport_salesbyasin_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_au_get_sales__traffic_report_hashid',
        'unitsordered',
        'totalorderitems',
        object_to_string('orderedproductsales'),
    ]) }} as _airbyte_salesbyasin_hashid,
    tmp.*
from {{ ref('au_get_sales_and_traf_2eport_salesbyasin_ab2') }} tmp
-- salesbyasin at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin
where 1 = 1

