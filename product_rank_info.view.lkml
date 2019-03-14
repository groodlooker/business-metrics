# If necessary, uncomment the line below to include explore_source.
# include: "sales.model.lkml"
view: product_rank_info {
  derived_table: {
#     datagroup_trigger: sales_default_datagroup
#     indexes: ["product_name"]
    explore_source: order_info {
      column: segment {}
      column: region {}
      column: state {}
      column: product_name {}
      column: total_sales {}
      column: category {}
      derived_column: dynamic_rank {
        sql: RANK() OVER(partition by
        region
        {% if order_info.segment._in_query %} , segment {% else %} {% endif %}
        {% if order_info.state._in_query %} , state {% else %} {% endif %}
        {% if order_info.category._in_query %} ,category {% else %} {% endif %} order by total_sales desc) ;;
      }
#       derived_column: segment_rank {
#         sql: RANK() OVER(PARTITION BY segment ORDER BY total_sales desc) ;;
#       }
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
  dimension: state {}
  dimension: category {}
  dimension: total_sales {
    hidden: yes
    value_format: "$#,##0"
    type: number
  }
  dimension: dynamic_rank {
    label: "Rank by"
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
