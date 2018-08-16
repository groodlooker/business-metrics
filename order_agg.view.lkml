view: order_aggregate {
  view_label: "Customer Metrics"
  derived_table: {
    explore_source: order_info {
      column: customer_name {}
      column: order_id {}
      column: order_date {}
      column: total_sales {}
    }
  }
  dimension: customer_name {
    hidden: yes
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

  dimension: next_purchase {
    type: date
    hidden: yes
    sql: (select min(o.order_date)
         from public.order_info o
         where ${TABLE}.customer_name = o.customer_name
         and o.order_date > ${TABLE}.order_date);;
  }

  dimension: days_btw_purchase {
    hidden: yes
    label: "Days Between Purchase"
    type: number
    sql: DATE_PART('day', ${next_purchase}::timestamp - ${order_date}::timestamp) ;;
  }

  measure: avg_days_btw_purchase {
    label: "Average Days Between Orders"
    type: average
    sql: ${days_btw_purchase} ;;
  }


}

explore: order_aggregate {}
