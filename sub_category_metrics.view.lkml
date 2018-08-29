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
        to_field: order_info.sub_category
        from_field: order_info.sub_category
      }
      column: sub_category {}
      column: customer_name {}
      column: most_recent_subcategory_purchase {field:order_info.most_recent_purchase}
#       column: segment {}
    }
  }
  dimension: sub_category {}
  dimension: customer_name {
    primary_key: yes
    hidden: yes
  }
  dimension: most_recent_subcategory_purchase {}
}
