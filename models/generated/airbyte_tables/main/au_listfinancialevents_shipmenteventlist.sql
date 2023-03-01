{{ config(
    schema = "main",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='au_listfinancialevents_shipmenteventlist_scd'
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
-- depends_on: {{ ref('au_listfinancialevents_shipmenteventlist_ab3') }}
select
    _airbyte_au_listfinancialevents_hashid,
    posteddate,
    orderfeelist,
    amazonorderid,
    sellerorderid,
    marketplacename,
    orderchargelist,
    shipmentfeelist,
    shipmentitemlist,
    directpaymentlist,
    orderfeeadjustmentlist,
    orderchargeadjustmentlist,
    shipmentfeeadjustmentlist,
    shipmentitemadjustmentlist,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shipmenteventlist_hashid
from {{ ref('au_listfinancialevents_shipmenteventlist_ab3') }}
-- shipmenteventlist at AU_ListFinancialEvents/ShipmentEventList from {{ ref('au_listfinancialevents') }}
where 1 = 1

