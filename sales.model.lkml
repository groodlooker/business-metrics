connection: "postgres-sales-transactions"

# include all the views
include: "*.view"


datagroup: sales_default_datagroup {
  sql_trigger: select CURRENT_DATETIME() ;;
  max_cache_age: "0 seconds"
}

access_grant: true_heir_to_the_throne {
  allowed_values: ["Targaryen","All"]
  user_attribute: house
}

persist_with: sales_default_datagroup

explore: order_info {
  persist_with: sales_default_datagroup
  view_name: order_info
  from: order_info
  join: cust_order_patterns {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_info.customer_name} = ${cust_order_patterns.customer_name} ;;
    relationship: many_to_many
  }
  join: orders_hist {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_info.customer_name} = ${orders_hist.customer_name} ;;
    relationship: many_to_one
  }
  join: product_rank_info {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_info.product_name} = ${product_rank_info.product_name}
    and ${order_info.region} = ${product_rank_info.region}
    {% if order_info.category._in_query %}
    and ${order_info.segment} = ${product_rank_info.segment}
    {% else %} {% endif %}
    {% if order_info.state._in_query %}
    and ${order_info.state} = ${product_rank_info.state}
    {% else %} {% endif %}
    {% if order_info.category._in_query %}
    and ${order_info.category} = ${product_rank_info.category}
    {% else %} {% endif %}
    ;;
    relationship: many_to_one
  }
  join: order_aggregate {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_aggregate.order_id} = ${order_info.order_id};;
    relationship: many_to_one
  }
  join: sub_category_metrics {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_info.customer_name} = ${sub_category_metrics.customer_name} ;;
    relationship: many_to_one
  }
  join: customer_rank {
    required_access_grants: [true_heir_to_the_throne]
    sql_on: ${order_info.customer_name} = ${customer_rank.customer_name}
    and ${order_info.order_year} = ${customer_rank.order_year}
    and ${order_info.region} = ${customer_rank.region};;
    relationship: many_to_one
  }
}

explore: regional_manager_sales_summary {
  extends: [order_info]
  join: regional_managers {
    sql_on: ${order_info.region} = ${regional_managers.region} ;;
    relationship: many_to_many
  }
}

explore: fiscal_sales {
  extends: [order_info]
  join: date_dimension_o {
    from: date_dimension
    sql_on: ${order_info.order_date} = ${date_dimension_o.date_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: date_dimension_s {
    from: date_dimension
    sql_on: ${order_info.ship_date} = ${date_dimension_s.date_pk} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: customer_nuances {
  from: order_info
  extends: [order_info]
  join: repeat_purchases {
    sql_on: ${order_info.customer_name} = ${repeat_purchases.customer_name} ;;
    relationship: many_to_one
    type: left_outer
  }
}
