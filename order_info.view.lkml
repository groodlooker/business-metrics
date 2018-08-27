view: order_info {
  sql_table_name: public.order_info ;;

  set: my_drills {
    fields: [product_name, order_month, region, total_sales, total_profit]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: city {
    type: string
    view_label: "Customer Location Details"
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    view_label: "Customer Location Details"
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: customer_id {
    type: string
    view_label: "Customer Attributes"
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    view_label: "Customer Attributes"
    sql: ${TABLE}.customer_name ;;
  }

  dimension: customer_phone_number {
    type: string
    view_label: "Customer Attributes"
    tags: ["phone"]
    sql: '9134618146' ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  measure: average_spend_per_order {
    type: number
    description: "Total sales divided by distinct orders. This number will equal total sales when drilled down to order_id detail."
    value_format_name: usd_0
    sql: ${total_sales} / ${unique_orders} ;;
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

  dimension: order_week_of_yearz {
    type: number
    sql: extract(week from ${TABLE}.order_date) ;;
    link: {
      label: "Compare by Product"
      url: "https://localhost:9999/explore/sales/order_info?fields=order_info.order_week_of_yearz,order_info.product_name,order_info.ly_sales,order_info.ty_sales&f[order_info.ytd]=Yes&f[order_info.choose_measure]=sales&f[order_info.order_week_of_yearz]={{value}}&f[order_info.segment]={{order_info.segment._value}}&sorts=order_info.ly_sales+desc&limit=500&column_limit=50"
    }
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: postal_code {
    type: string
    view_label: "Customer Location Details"
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
    view_label: "Customer Location Details"
    sql: ${TABLE}.region ;;
  }

  dimension: row_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.row_id ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: segment {
    type: string
    view_label: "Customer Attributes"
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
    view_label: "Customer Location Details"
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
    drill_fields: [my_drills*]
    sql: ${sales} ;;
  }

  measure: total_profit {
    type: sum
    label: "Total Profit"
    value_format_name: usd_0
    drill_fields: [product_name,region]
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
    sql: ${order_week_of_year} <= Extract(week from now()) ;;
  }

  measure: ty_sales {
    type: sum
    value_format_name: usd_0
    label: "This Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    filters: {
      field: ty
      value: "yes"
    }
    drill_fields: [my_drills*]
    sql: ${TABLE}.{% parameter choose_measure %} ;;
  }

#   dimension: next_purchase {
#     type: date
#     sql: (select min(o.order_date)
#          from public.order_info o
#          where ${TABLE}.customer_name = o.customer_name
#          and o.order_date > ${TABLE}.order_date);;
#   }
#
#   dimension: days_btw_purchase {
#     label: "Days Between Purchase"
#     type: number
#     sql: DATE_PART('day', ${next_purchase}::timestamp - ${order_date}::timestamp) ;;
#   }
#
#   measure: avg_days_btw_purchase {
#     label: "Average Days Between Orders"
#     type: average
#     sql: ${days_btw_purchase} ;;
#   }


  measure: ly_sales {
    type: sum
    value_format_name: usd_0
    label: "Last Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    filters: {
      field: ly
      value: "yes"
    }
    drill_fields: [my_drills*]
    sql: ${TABLE}.{% parameter choose_measure %} ;;
  }

  measure: difference_in_sales_yoy {
    type: number
    value_format_name: usd_0
    sql: ${ty_sales} - ${ly_sales} ;;
  }

  measure: percent_diff_in_sales_yoy {
    type: number
    value_format_name: percent_1
    sql:(${ty_sales} - ${ly_sales}) / ${ly_sales} ;;
  }

  measure: ty_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum This Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    sql: ${ty_sales} ;;
  }

  measure: ly_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum Last Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    sql: ${ly_sales} ;;
  }

  measure: running_diff {
    type: running_total
    value_format_name: usd_0
    label: "Running Difference of {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    sql: ${ty_running_total} - ${ly_running_total} ;;
  }

  measure: unique_orders {
    type: count_distinct
    drill_fields: [order_month, unique_orders]
    label: "Unique Orders"
    sql: ${order_id} ;;
  }

  measure: customer_cnt {
    type: count_distinct
    label: "Count of Customers (histogram)"
    sql: ${customer_name} ;;
    drill_fields: [customer_name]
  }

  measure: product_max {
    type: string
    label: "Product Name Aggregated"
    drill_fields: [customer_name, total_sales]
    description: "You can leverage this field with rank and a pivot of region, segment or order year"
    sql: max(${product_name}) ;;
  }

  parameter: choose_measure {
    type: unquoted
    default_value: "sales"
    label: "Last Year Metric"
    allowed_value: {
      label: "Sales"
      value: "sales"
    }
    allowed_value: {
      label: "Profit"
      value: "profit"
    }
#making change for deploy
  }

}
