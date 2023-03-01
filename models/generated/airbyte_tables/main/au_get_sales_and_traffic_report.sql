{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_get_sales_and_traffic_report_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_get_sales_and_traffic_report_ab3') }}
select
    childasin,
    parentasin,
    salesbyasin,
    queryenddate,
    trafficbyasin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_au_get_sales__traffic_report_hashid
from {{ ref('au_get_sales_and_traffic_report_ab3') }}
-- au_get_sales_and_traffic_report from {{ source('main', '_airbyte_raw_au_get_sales_and_traffic_report') }}
where 1 = 1

