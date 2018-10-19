view: product_profit {
    derived_table: {
      explore_source: order_info {
        column: this_year_sales {}
        column: last_year_sales {}
        column: total_sales {}
        column: total_profit {}
        column: product_name {}
        column: unique_orders {}
      }
    }
    dimension: this_year_sales {
      label: "Order Info This Year sales"
      value_format: "$#,##0"
      type: number
    }
    dimension: last_year_sales {
      label: "Order Info Last Year sales"
      value_format: "$#,##0"
      type: number
    }
    dimension: total_sales {
      value_format: "$#,##0"
      type: number
    }
    dimension: total_profit {
      value_format: "$#,##0"
      type: number
    }
    dimension: product_name {
      hidden: no
    }
    dimension: unique_orders {
      type: number
    }
  }

  explore: product_profit {}
