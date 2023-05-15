    {% set categorys = [
        "Apps & Games",
        "Beauty",
        "Kitchen",
        "Books",
        "Clothing, Shoes & Accessories",
        "Movies & TV",
        "Sports, Fitness & Outdoors",
    ] %}

select
    id,
    gender,
    {{ age_in_years("birth_date") }} as age,
    sum(amount) as total_expense,
    min(transaction_date) as first_purchase_date,
    max(transaction_date) as last_purchase_date,
    {% for cat in categorys %}
        sum(
            case when category = '{{ cat }}' then amount else 0 end
        ) as {{ cat.replace(" ", "_").replace(",", "").replace("&", "and") | lower }}_amount
        {%- if not loop.last -%}, {% endif -%}

    {% endfor %}

from {{ ref("contacts_joined_with_transactions") }}
group by 1, 2, 3
