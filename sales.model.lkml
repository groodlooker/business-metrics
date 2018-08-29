connection: "postgres-sales-transactions"

# include all the views
include: "*.view"

datagroup: sales_default_datagroup {
  sql_trigger: select max(current_date) ;;
  max_cache_age: "24 hour"
}

persist_with: sales_default_datagroup

explore: order_info {
  view_name: order_info
  from: order_info
  join: cust_order_patterns {
    sql_on: ${order_info.customer_name} = ${cust_order_patterns.customer_name} ;;
    relationship: many_to_many
  }
  join: orders_hist {
    sql_on: ${order_info.customer_name} = ${orders_hist.customer_name} ;;
    relationship: many_to_one
  }
  join: product_rank_info {
    sql_on: ${order_info.product_name} = ${product_rank_info.product_name}
    and ${order_info.region} = ${product_rank_info.region}
    and ${order_info.order_year} = ${product_rank_info.order_year};;
    relationship: many_to_one
  }
  join: order_aggregate {
    sql_on: ${order_aggregate.order_id} = ${order_info.order_id};;
    relationship: many_to_one
  }
  join: sub_category_metrics {
    sql_on: ${order_info.customer_name} = ${sub_category_metrics.customer_name} ;;
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
