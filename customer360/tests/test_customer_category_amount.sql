{% set categorys = [
    "Apps & Games",
    "Beauty",
    "Kitchen",
    "Books",
    "Clothing, Shoes & Accessories",
    "Movies & TV",
    "Sports, Fitness & Outdoors",
] %}

with
    referent as (
        select category, sum(amount) as amount_t1
        from {{ ref("contacts_joined_with_transactions") }}
        group by 1

    ),

    test_data as (
        {% for cat in categorys %}
            select
                '{{ cat }}' as category,
                sum(
                    {{ cat.replace(" ", "_").replace(",", "").replace("&", "and") | lower }}_amount
                ) as amount_t2

            from {{ ref("customers") }}
            {% if not loop.last -%}
                union all
            {% endif %}
        {% endfor %}

    ),

    prep as (
        select *, round(amount_t2 - amount_t1) as dif
        from referent as r
        inner join test_data as td on r.category = td.category
    )

select *
from prep
where dif <> 0
