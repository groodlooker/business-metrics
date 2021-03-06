view: order_info {
  sql_table_name: public.order_info ;;

  set: my_drills {
    fields: [order_id, customer_name, order_date, region, total_sales, total_profit]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  filter: previous_period_filter {
    type: date
    description: "Use this filter for period analysis"
  }

  dimension: period_result {
    type: date
    sql: {% date_start previous_period_filter %} ;;
  }

  dimension: period_result_end {
    type: date
    sql: {% date_end previous_period_filter %} ;;
  }

  dimension: cur_time {
    type: date
    sql: CURRENT_TIMESTAMP ;;
  }

  dimension: assigned_region {
    sql: {{_user_attributes["region"]}} ;;
  }

  dimension: region_filter {
    type: yesno
    sql: ${region} in ({{_user_attributes["region"]}}) ;;
  }




#    {% if orders.created_date._in_query %}
#       orders
#     {% elsif orders.created_week._in_query %}
#       orders_smry_week
#     {% elsif orders.created_month._in_query %}
#       orders_smry_month
#     {% else %}
#       orders_smry_year  (case when ${category} = 'Technology' then ${sub_category} end)
#     {% endif %}

  measure: sales_formatter {
    sql: ${sales} ;;
    html:  <div style="font-size:4em;">{{rendered_value}}</div> ;;
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
      day_of_week,
      week,
      week_of_year,
      month,
      day_of_month,
      month_num,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date + INTERVAL '2 year' ;;
  }

  measure: distinct_years {
    type: count_distinct
    sql: ${order_year} ;;
  }

  dimension: order_week_of_the_year {
    type: number
    sql: extract(week from ${TABLE}.order_date) ;;
    link: {
      label: "Compare by Product"
      url: "https://localhost:9999/explore/sales/order_info?fields=order_info.order_week_of_the_year,order_info.product_name,order_info.last_year_sales,order_info.this_year_sales&f[order_info.ytd]=Yes&f[order_info.choose_measure]=sales&f[order_info.order_week_of_the_year]={{value}}&f[order_info.segment]={{order_info.segment._value}}&sorts=order_info.last_year_sales+desc&limit=500&column_limit=50"
    }
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  measure: grand_total_sales {
    type: number
    sql: max((select sum(sales) from order_info));;
    html: <div style="width:100px; height: 100px; border-radius:50%; background-color:rgba(25,35,150,{{value}}">{{value}}</div> ;;
  }

  measure: formatted_countd {
    type: count_distinct
    sql: ${order_id} ;;
    html: <div style="line-height: {{circle_size._parameter_value}}px; text-align:center; margin-right: auto; margin-left: auto; width:{{circle_size._parameter_value}}px; height: {{circle_size._parameter_value}}px; border-radius:50%; background-color:rgba(25,35,150,{{percent_by_region._value}}">
    <span style="color:black;">{{rendered_value}}</span></div> ;;
    # html:  ;;
  }

  parameter: circle_size {
    description: "use in conjunction with formatted_countd"
    type: number
    default_value: "35"
  }

  parameter: font_color {
    description: "use in conjunction with progress bar"
    type: unquoted
    default_value: "white"
  }

  parameter: font_size {
    description: "control font of progress bar"
    type: number
    default_value: "12"
  }

  measure: grand_order_count {
    type: number
    sql: max((select count(distinct order_id) from order_info)) ;;
  }

  # <div><i class="fa fa-circle" aria-hidden="true"></i></div>
  # color1: 151,206,255
  # color2: 114,127,157

  # R =  (114-151) * fraction + 151
  # G =  (127-206) * fraction + 206
  # B =  (157-255) * fraction + 255

  measure: percent_by_region {
    type: number
    value_format_name: percent_1
    sql: (${total_sales} / nullif(${grand_total_sales},0)) ;;
    html: <div class="container-fluid" style="height:{{circle_size._parameter_value}}px;"><div class="progress" style="line-height:{{circle_size._parameter_value}}px; height:{{circle_size._parameter_value}}px;">
  <div class="progress-bar" role="progressbar" aria-valuenow="{{ value | times: 100 }}" aria-valuemin="0" aria-valuemax="100" style="background-color:#8EA6BB !important; width:{{ value | times: 100 }}%">
    <span style="float:left;text-align:center;font-size:{{font_size._parameter_value}}px !important;color:{{font_color._parameter_value}};line-height:{{circle_size._parameter_value}}px; height:{{circle_size._parameter_value}}px;">{{rendered_value}}</span>
  </div>
</div></div> ;;
  }

  dimension: logo_erizer {
    sql: 1 ;;
    html: <img src="//logo.clearbit.com/spotify.com?size=100"> ;;
  }

  dimension: postal_code {
    type: zipcode
    view_label: "Customer Location Details"
#     map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.postal_code ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    drill_fields: [customer_name,total_sales,total_profit]
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
    link: {
      label: "Segment Lookup"
      url: "{% if value == 'Consumer' %} www.google.com {% endif %}"
    }
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
    label: "{% if order_info.category._in_query %} (Category) Sub Category
       {% else %} Sub Categories
    {% endif %}"
#     link: {
#       label: "Explain the Difference"
# #       url: "https://localhost:9999/explore/sales/order_info?fields=order_info.region,order_info.product_name,order_info.difference_in_sales_yoy,order_info.last_year_sales,order_info.this_year_sales&f[order_info.segment]={{order_info.segment._value}}&f[order_info.ytd]=Yes&f[order_info.sub_category]={{value}}&sorts=order_info.difference_in_sales_yoy,order_info.region,order_info.product_name&limit=5&column_limit=5&vis=%7B%22stacking%22%3A%22%22%2C%22"
#     }
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
    sql: ${order_year} = Extract(year from now()) - 1  ;;

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

  measure: this_year_sales {
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

  measure: this_year_profit {
    type: sum
    value_format_name: usd_0
    filters: {
      field: ty
      value: "yes"
    }
    sql: ${profit} ;;
  }

  measure: last_year_profit {
    type: sum
    value_format_name: usd_0
    filters: {
      field: ly
      value: "yes"
    }
    sql: ${profit} ;;
  }

  measure: this_year_orders {
    type: count_distinct
    value_format_name: usd_0
    filters: {
      field: ty
      value: "yes"
    }
    sql: ${order_id} ;;
  }

  measure: last_year_orders {
    type: count_distinct
    value_format_name: usd_0
    filters: {
      field: ly
      value: "yes"
    }
    sql: ${order_id} ;;
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


  measure: last_year_sales {
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
    sql: ${this_year_sales} - ${last_year_sales} ;;
    html: <div align="center">{{rendered_value}}</div> ;;
  }

  measure: percent_diff_in_sales_yoy {
    type: number
    value_format_name: percent_1
    drill_fields: [product_name, difference_in_sales_yoy]
    sql:(${this_year_sales} - ${last_year_sales}) / NULLIF(${last_year_sales},0) ;;
    html: {% if value < 0 %}
    <div><img src="https://localhost:8443/icon-set/down-arrow.png" height=10 width=10>&ensp;{{ rendered_value }}</div>
    {% else %}
    <div>{{ rendered_value }}</div>
    {% endif %};;
  }

  measure: ty_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum This Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    sql: ${this_year_sales} ;;
  }

  measure: ly_running_total{
    type: running_total
    value_format_name: usd_0
    label: "Running Sum Last Year {% parameter choose_measure %}"
    group_label: "Year over Year Metrics"
    sql: ${last_year_sales} ;;
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
    sql: ${customer_name}
    drill_fields: [customer_name]
  }

  dimension: customer_ranked_in_top_5 {
    type: yesno
    sql: ${customer_rank.customer_rank_by_year_region} < 6 ;;
  }

  measure: summartext {
    sql: 1 ;;
    html: <center><div><p style="font-size: 65%">This brought you a total of<p><div></center>
          <div><p style="color: #3F97F8; font-size: 65%">{{unique_orders._rendered_value}} Applies</p></div>
          <div><p style="font-size: 40%">Desktop Applies: <font style="color: #3F97F8;">{{desktop._rendered_value}}</font></p></div>
          <div><p style="font-size: 40%">Mobile Applies: <font style="color: #3F97F8;">{{mobile._rendered_value}}</font></p></div>
    ;;
  }

  measure: compared_to_text {
    sql: 1 ;;
    html: <center><div><p style="font-size: 50%">Compared to other employers like you, you performed<p><div></center>
          <div><p style="color: #F39875; font-size: 50%">{{stuff._rendered_value}}{% if  stuff._value > 0 %} above {% else %} below {% endif %}your industry's average</p></div>
    ;;
  }

  measure: stuff {
    type: number
    value_format_name: percent_0
    sql: cast(${desktop} as float) / cast(${unique_orders} as float) ;;
  }

  measure: desktop {
    sql: ${order_id} ;;
    type: count_distinct
    filters: {
      field: segment
      value: "Consumer"
    }
  }

  measure: mobile {
    sql: ${order_id} ;;
    type: count_distinct
    filters: {
      field: segment
      value: "-Consumer"
    }
  }

  measure: product_max {
    type: string
    label: "Product Name Aggregated"
    drill_fields: [customer_name, total_sales]
    description: "You can leverage this field with rank and a pivot of region, segment or order year"
    sql: max(${product_name}) ;;
  }

  measure: most_recent_purchase {
    hidden: no
    type: date
    sql: max(${order_date}) ;;
  }

  dimension: customer_is_due_for_purchase {
    type: yesno
    sql: extract (day from (now() - ${sub_category_metrics.most_recent_subcategory_purchase})) >= 364 ;;
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
