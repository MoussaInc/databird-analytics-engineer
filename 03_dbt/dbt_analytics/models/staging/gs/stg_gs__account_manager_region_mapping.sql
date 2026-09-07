SELECT
    -- concat(account_manager, '-', state) as mapping_id,
    {{ dbt_utils.surrogate_key(['account_manager', 'state']) }} as mapping_id,
    state,
    account_manager
FROM {{ source('gs', 'account_manager_region_mapping') }}