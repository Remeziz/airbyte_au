{{ config(
    schema = "_airbyte_main",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('au_get_sales_and_traf_3deredproductsales_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_salesbyasin_hashid',
        'amount',
        'currencycode',
    ]) }} as _airbyte_orderedproductsales_hashid,
    tmp.*
from {{ ref('au_get_sales_and_traf_3deredproductsales_ab2') }} tmp
-- orderedproductsales at AU_GET_SALES_AND_TRAFFIC_REPORT/salesByAsin/orderedProductSales
where 1 = 1

