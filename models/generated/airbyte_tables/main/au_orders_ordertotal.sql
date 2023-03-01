{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_orders_ordertotal_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('au_orders_ordertotal_ab3') }}
select
    _airbyte_au_orders_hashid,
    amount,
    currencycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ordertotal_hashid
from {{ ref('au_orders_ordertotal_ab3') }}
-- ordertotal at AU_Orders/OrderTotal from {{ ref('au_orders') }}
where 1 = 1

