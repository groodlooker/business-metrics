# If necessary, uncomment the line below to include explore_source.
# include: "sales.model.lkml"

view: sub_category_metrics {
  derived_table: {
    explore_source: order_info {
      bind_filters: {
        to_field: order_info.segment
        from_field: order_info.segment
      }
      bind_filters: {
        to_field: order_info.ytd
        from_field: order_info.ytd
      }
      column: sub_category {}
      column: percent_diff_in_sales_yoy {}
#       column: segment {}
    }
  }
  dimension: sub_category {
    primary_key: yes
    hidden: yes
  }
  dimension: percent_diff_in_sales_yoy {
    value_format: "#,##0.0%"
    type: number
    html: {% if value < 0 %}
    <div><img src="https://localhost:8443/icon-set/down-arrow.png" height=10 width=10>&ensp;{{ rendered_value }}</div>
    {% else %}
    <div>{{ rendered_value }}</div>
    {% endif %};;
  }
}
