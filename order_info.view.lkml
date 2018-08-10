view: order_info {
  sql_table_name: public.order_info ;;

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: postal_code {
    type: string
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.postal_code ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}.row_id ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension_group: ship {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ship_date ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.ship_mode ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name, product_name]
  }

  measure: total_sales {
    type: sum
    label: "Total Sales"
    value_format_name: usd_0
    sql: ${sales} ;;
  }

  measure: total_profit {
    type: sum
    label: "Total Profit"
    value_format_name: usd_0
    sql: ${profit} ;;
  }

  measure: avg_discount {
    type: average
    value_format_name: percent_1
    label: "Average Discount"
    sql: ${discount} ;;
  }

  dimension: ly {
    type: yesno
    hidden: yes
    group_label: "Year over Year Metrics"
    sql: ${order_year} = Extract(year from now()) - 1 ;;

  }

  dimension: ty {
    type: yesno
    hidden: yes
    group_label: "Year over Year Metrics"
    sql: ${order_year} = Extract(year from now()) ;;

  }

  dimension: ytd {
    type: yesno
    group_label: "Year over Year Metrics"
    sql: ${order_day_of_year} <= Extract(doy from now()) ;;
  }

  measure: ty_sales {
    type: sum
    value_format_name: usd_0
    label: "This Year Sales"
    group_label: "Year over Year Metrics"
    filters: {
      field: ty
      value: "yes"
    }
    sql: ${sales} ;;
  }

  measure: ly_sales {
    type: sum
    value_format_name: usd_0
    label: "Last Year Sales"
    group_label: "Year over Year Metrics"
    filters: {
      field: ly
      value: "yes"
    }
    sql: ${sales} ;;
  }

  measure: ty_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum This Year Sales"
    group_label: "Year over Year Metrics"
    sql: ${ty_sales} ;;
  }

  measure: ly_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum Last Year Sales"
    group_label: "Year over Year Metrics"
    sql: ${ly_sales} ;;
  }

  measure: unique_orders {
    type: count_distinct
    label: "Unique Orders"
    sql: ${order_id} ;;
  }

  measure: customer_cnt {
    type: count_distinct
    label: "Count of Customers (histogram)"
    sql: ${customer_name} ;;
    drill_fields: [customer_name]
  }


}
