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
}
