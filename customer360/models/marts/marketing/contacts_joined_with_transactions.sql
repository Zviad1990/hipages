SELECT 
    contacts.*,
    transactions.id as transaction_id,
    transactions.transaction_date,
    transactions.amount,
    transactions.item_count,
    transactions.category
FROM {{ ref('stg_web__transactions') }} as transactions
inner JOIN {{ ref('stg_sf__contacts') }} as contacts ON contacts.id = transactions.contact_id
