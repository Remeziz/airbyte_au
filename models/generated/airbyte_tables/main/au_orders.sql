{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_orders_scd'
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
-- depends_on: {{ ref('au_orders_ab3') }}
select
    isispu,
    isprime,
    ordertype,
    seller_id,
    issoldbyab,
    ordertotal,
    orderstatus,
    purchasedate,
    saleschannel,
    amazonorderid,
    marketplaceid,
    paymentmethod,
    sellerorderid,
    ispremiumorder,
    lastupdatedate,
    latestshipdate,
    isbusinessorder,
    earliestshipdate,
    shipservicelevel,
    fulfillmentchannel,
    isreplacementorder,
    numberofitemsshipped,
    paymentmethoddetails,
    isglobalexpressenabled,
    numberofitemsunshipped,
    shipmentservicelevelcategory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_au_orders_hashid
from {{ ref('au_orders_ab3') }}
-- au_orders from {{ source('main', '_airbyte_raw_au_orders') }}
where 1 = 1

