view: customer_rank {
  derived_table: {
    datagroup_trigger: sales_default_datagroup
    indexes: ["customer_name"]
    explore_source: order_info {
      column: region {}
      column: order_year {}
      column: customer_name {}
      column: total_sales {}
      derived_column: customer_rank_by_year_region {
        sql: RANK() OVER(partition by order_year, region order by total_sales desc) ;;
      }
#       derived_column: segment_rank {
#         sql: RANK() OVER(PARTITION BY segment ORDER BY total_sales desc) ;;
#       }
      derived_column: row_num {
        sql: row_number() over() ;;
      }
    }
  }

  dimension: order_year {
    hidden: yes
  }
  dimension: region {
    hidden: yes
  }
  dimension: customer_name {
    hidden: yes
  }
  dimension: total_sales {
    hidden: yes
    value_format: "$#,##0"
    type: number
  }
  dimension: customer_rank_by_year_region {
    label: "Customer Rank by Year & Region"
    type: number
  }
#   dimension: segment_rank {
#     label: "Product Rank by Segment"
#     type: number
#   }
  dimension: row_num {
    primary_key: yes
    hidden: yes
    label: "Row Id"
  }
}
