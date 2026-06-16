{% snapshot orders_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='updated_at',
        hard_deletes='ignore'
    )
}}

select
    order_id,
    order_status,
    updated_at
from {{ ref('stg_orders') }}

{% endsnapshot %}