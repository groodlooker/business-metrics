view: repeat_purchases {
  derived_table: {
    explore_source: order_info {
      column: customer_name {}
      column: years_a_customer {field:order_info.distinct_years}
    }
  }
  dimension: customer_name {
    label: "Customer Attributes Customer Name"
    primary_key: yes
    hidden: yes
  }
  dimension: years_a_customer {
    type: number
  }
}
