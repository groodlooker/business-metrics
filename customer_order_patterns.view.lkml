# If necessary, uncomment the line below to include explore_source.
# include: "sales.model.lkml"

view: cust_order_patterns {
  derived_table: {
    explore_source: order_info {
      column: customer_name {}
      column: order_id {}
      column: total_sales {}
    }
  }
  dimension: customer_name {
    hidden: yes
  }
  dimension: order_id {
    hidden: yes
    primary_key: yes
  }
  dimension: total_sales {
    value_format: "$#,##0"
    type: number
    hidden: yes
  }
  measure: avg_order {
    type: average
    label: "Avg Customer Order Size"
    value_format_name: usd
    sql: ${total_sales} ;;
  }
}
