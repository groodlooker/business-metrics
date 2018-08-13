# If necessary, uncomment the line below to include explore_source.
# include: "sales.model.lkml"

view: product_rank_info {
  derived_table: {
    persist_for: "24 hours"
    indexes: ["product_name"]
    explore_source: order_info {
      column: region {}
      column: segment {}
      column: product_name {}
      column: total_sales {}
      derived_column: regional_rank {
        sql: RANK() OVER(partition by region order by total_sales desc) ;;
      }
      derived_column: segment_rank {
        sql: RANK() OVER(PARTITION BY segment ORDER BY total_sales desc) ;;
      }
      derived_column: row_num {
        sql: row_number() over(order by region, product_name) ;;
      }
    }
  }
  dimension: region {
    hidden: yes
  }
  dimension: segment {
    hidden: yes
  }
  dimension: product_name {
    hidden: yes
  }
  dimension: total_sales {
    hidden: yes
    value_format: "$#,##0"
    type: number
  }
  dimension: regional_rank {
    label: "Product Rank by Region"
    type: number
  }
  dimension: segment_rank {
    label: "Product Rank by Segment"
    type: number
  }
  dimension: row_num {
    primary_key: yes
    hidden: yes
    label: "Row Id"
  }
}
