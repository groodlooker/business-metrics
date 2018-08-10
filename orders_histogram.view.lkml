# If necessary, uncomment the line below to include explore_source.
# include: "sales.model.lkml"

view: orders_hist {
  derived_table: {
    explore_source: order_info {
      column: customer_name {}
      column: unique_orders {}
    }
  }
  dimension: customer_name {
    primary_key: yes
    hidden: yes
  }
  dimension: unique_orders {
    type: number
  }
}
