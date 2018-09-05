view: date_dimension {
  sql_table_name: public.date_dimension ;;

  dimension_group: date_key {
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
    sql: ${TABLE}.date_key ;;
  }

  dimension: date_pk {
    hidden: yes
    type: date
    sql: ${date_key_date} ;;
  }

  dimension: day {
    type: number
    sql: ${TABLE}.day ;;
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}.day_of_week ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: week {
    type: number
    sql: ${TABLE}.week ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
