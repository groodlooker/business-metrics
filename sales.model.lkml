connection: "postgres-sales-transactions"

# include all the views
include: "*.view"

datagroup: sales_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sales_default_datagroup

explore: order_info {
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
}
