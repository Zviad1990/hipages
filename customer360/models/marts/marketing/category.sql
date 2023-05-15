select
    category,
    count(transaction_id) as total_transactions,
    sum(amount) as total_amount,
    round(avg(amount)) as average_amount,
    sum(item_count) as total_item_count,
    round(avg(item_count)) as average_item_count,
    count(
        distinct case when gender = 'F' then concat(id, gender) else null end
    ) as count_unique_female_customers,
    count(
        distinct case when gender = 'M' then concat(id, gender) else null end
    ) as count_unique_male_customers,
    avg(
        case when gender = 'F' then {{ age_in_years("birth_date") }} else null end
    ) as average_age_female_customers,
    avg(
        case when gender = 'M' then {{ age_in_years("birth_date") }} else null end
    ) as average_age_male_customers
from {{ ref("contacts_joined_with_transactions") }}
group by 1
