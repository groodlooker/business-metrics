view: order_aggregate {
  view_label: "Customer Metrics"
  derived_table: {
    datagroup_trigger: sales_default_datagroup
    indexes: ["order_id","customer_name"]
    explore_source: order_info {
      column: customer_name {}
      column: order_id {}
      column: order_date {}
      column: total_sales {}
      derived_column: next_order {
        sql: lag(order_date,1) over(partition by customer_name order by order_date asc) ;;
      }
      derived_column: order_sequence {
        sql: row_number() over(partition by customer_name order by order_date asc) ;;
      }
    }
  }
  dimension: customer_name {
    hidden: yes
    sql: ${TABLE}.customer_name ;;
  }
  dimension: order_id {
    primary_key: yes
    hidden: yes
  }
  dimension: order_date {
    type: date
    hidden: yes
  }
  dimension: total_sales {
    hidden: yes
  }
  dimension: days_btw_orders {
    hidden: yes
    type: number
    sql: date_part('day', ${order_date} - ${TABLE}.next_order::timestamp) ;;
  }
  dimension: order_sequence {
    sql: ${TABLE}.order_sequence ;;
  }
  measure: average_days_between_orders {
    type: average
    value_format_name: decimal_1
    sql: ${days_btw_orders} ;;
  }

#
#   dimension: next_purchase {
#     type: date
#     hidden: yes
#     sql: (select min(o.order_date)
#          from public.order_info o
#          where ${TABLE}.customer_name = o.customer_name
#          and o.order_date > ${TABLE}.order_date);;
#   }
#   dimension: days_btw_purchase {
#     hidden: yes
#     label: "Days Between Purchase"
#     type: number
#     sql: DATE_PART('day', ${next_purchase}::timestamp - ${order_date}::timestamp) ;;
#   }
#
#   measure: avg_days_btw_purchase {
#     label: "Average Days Between Orders"
#     type: average
#     value_format_name: decimal_1
#     sql: ${days_btw_purchase} ;;
#   }


}
