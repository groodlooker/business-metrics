view: sub_rank {
    derived_table: {
      explore_source: order_info {
        column: order_year {}
        column: total_sales {}
        column: sub_category {}
        derived_column: sub_rank {
          sql: RANK() OVER(PARTITION BY order_year ORDER BY total_sales desc) ;;
        }
      }
    }
    dimension: order_year {
      type: date_year
    }
    dimension: total_sales {
      value_format: "$#,##0"
      type: number
    }
    dimension: sub_category {}
    dimension: sub_rank {
      type: number
    }
  }

explore: sub_rank {}
