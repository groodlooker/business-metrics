- dashboard: template
  title: Segment Manager's Year over Year Sales Performance
  layout: newspaper
  elements:
  - title: Year over Year Sales Performance
    name: Year over Year Sales Performance
    model: sales
    explore: order_info
    type: single_value
    fields: [order_info.segment, order_info.this_year_sales, order_info.last_year_sales]
    filters:
      order_info.segment: Consumer
    sorts: [order_info.this_year_sales desc, order_info.segment]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
    custom_color_enabled: true
    custom_color: "#A918B4"
    show_single_value_title: true
    single_value_title: Consumer
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 0
    col: 0
    width: 8
    height: 6
  - title: Untitled
    name: Untitled
    model: sales
    explore: order_info
    type: single_value
    fields: [order_info.this_year_sales, order_info.last_year_sales, order_info.segment]
    filters:
      order_info.segment: Home Office
    sorts: [order_info.this_year_sales desc, order_info.segment]
    limit: 500
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
    custom_color_enabled: true
    custom_color: "#149888"
    show_single_value_title: true
    single_value_title: Home Office
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 0
    col: 8
    width: 8
    height: 6
  - title: card
    name: card
    model: sales
    explore: order_info
    type: single_value
    fields: [order_info.this_year_sales, order_info.last_year_sales, order_info.segment]
    filters:
      order_info.segment: Corporate
    sorts: [order_info.this_year_sales desc]
    limit: 500
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
    custom_color_enabled: true
    custom_color: "#FC2E31"
    show_single_value_title: true
    single_value_title: Corporate
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: []
    y_axes: []
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 0
    col: 16
    width: 8
    height: 6
  - title: Consumer
    name: Consumer
    model: sales
    explore: order_info
    type: looker_area
    fields: [order_info.running_diff, order_info.segment, order_info.order_week_of_the_year]
    filters:
      order_info.segment: Consumer
    sorts: [order_info.order_week_of_the_year]
    limit: 500
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      order_info.running_diff: "#A918B4"
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    hidden_fields: [order_info.segment]
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 6
    col: 0
    width: 8
    height: 6
  - title: Corporate
    name: Corporate
    model: sales
    explore: order_info
    type: looker_area
    fields: [order_info.running_diff, order_info.segment, order_info.order_week_of_the_year]
    filters:
      order_info.segment: Corporate
    sorts: [order_info.order_week_of_the_year]
    limit: 500
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      order_info.running_diff: "#FC2E31"
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    hidden_fields: [order_info.segment]
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 6
    col: 16
    width: 8
    height: 6
  - title: Home Office
    name: Home Office
    model: sales
    explore: order_info
    type: looker_area
    fields: [order_info.running_diff, order_info.segment, order_info.order_week_of_the_year]
    filters:
      order_info.segment: Home Office
    sorts: [order_info.order_week_of_the_year]
    limit: 500
    trellis: ''
    stacking: ''
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      order_info.running_diff: "#149888"
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    hidden_fields: [order_info.segment]
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
      Region: order_info.region
    row: 6
    col: 8
    width: 8
    height: 6
  - title: Performance by Region
    name: Performance by Region
    model: sales
    explore: order_info
    type: looker_donut_multiples
    fields: [order_info.this_year_sales, order_info.region, order_info.segment]
    pivots: [order_info.region]
    filters:
      order_info.segment: ''
    sorts: [order_info.region 0, sorter]
    limit: 500
    dynamic_fields: [{table_calculation: sorter, label: sorter, expression: 'if(${order_info.segment}
          = "Corporate",100,1)', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: number}]
    show_value_labels: true
    font_size: 12
    colors: ["#5245ed", "#ed6168", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a",
      "#706080", "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    series_colors: {}
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: [sorter]
    y_axes: []
    listen:
      Year to Date?: order_info.ytd
      Choose your Measure: order_info.choose_measure
    row: 31
    col: 0
    width: 24
    height: 8
  - title: Product Rank by Region
    name: Product Rank by Region
    model: sales
    explore: order_info
    type: table
    fields: [order_info.product_max, product_rank_info.dynamic_rank, order_info.region]
    pivots: [order_info.region]
    filters:
      order_info.segment: Consumer
      order_info.choose_measure: sales
      product_rank_info.dynamic_rank: "<=5"
    sorts: [order_info.region 0, product_rank_info.dynamic_rank]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      order_info.product_max: Product Name
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    series_types: {}
    listen:
      Region: order_info.region
    row: 21
    col: 0
    width: 8
    height: 10
  - title: Product Rank by Region seg
    name: Product Rank by Region seg
    model: sales
    explore: order_info
    type: table
    fields: [order_info.product_max, product_rank_info.dynamic_rank, order_info.region]
    pivots: [order_info.region]
    filters:
      order_info.segment: Home Office
      order_info.choose_measure: sales
      product_rank_info.dynamic_rank: "<=5"
    sorts: [order_info.region 0, product_rank_info.dynamic_rank]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      order_info.product_max: Product Name
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    series_types: {}
    listen:
      Region: order_info.region
    row: 21
    col: 8
    width: 8
    height: 10
  - title: Product Rank by Region corp
    name: Product Rank by Region corp
    model: sales
    explore: order_info
    type: table
    fields: [order_info.product_max, product_rank_info.dynamic_rank, order_info.region]
    pivots: [order_info.region]
    filters:
      order_info.segment: Corporate
      order_info.choose_measure: sales
      product_rank_info.dynamic_rank: "<=5"
    sorts: [order_info.region 0, product_rank_info.dynamic_rank]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      order_info.product_max: Product Name
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    series_types: {}
    listen:
      Region: order_info.region
    row: 21
    col: 16
    width: 8
    height: 10
  - title: Consumer Sub-Category Change
    name: Consumer Sub-Category Change
    model: sales
    explore: order_info
    type: table
    fields: [order_info.sub_category, order_info.percent_diff_in_sales_yoy]
    filters:
      order_info.segment: Consumer
      order_info.ytd: 'Yes'
    sorts: [order_info.percent_diff_in_sales_yoy desc]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Region: order_info.region
    row: 12
    col: 0
    width: 8
    height: 9
  - title: Home Office Sub-Category Change
    name: Home Office Sub-Category Change
    model: sales
    explore: order_info
    type: table
    fields: [order_info.sub_category, order_info.percent_diff_in_sales_yoy]
    filters:
      order_info.segment: Home Office
      order_info.ytd: 'Yes'
    sorts: [order_info.percent_diff_in_sales_yoy desc]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Region: order_info.region
    row: 12
    col: 8
    width: 8
    height: 9
  - title: CorporateSub-Category Change
    name: CorporateSub-Category Change
    model: sales
    explore: order_info
    type: table
    fields: [order_info.sub_category, order_info.percent_diff_in_sales_yoy]
    filters:
      order_info.segment: Corporate
      order_info.ytd: 'Yes'
    sorts: [order_info.percent_diff_in_sales_yoy desc]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Region: order_info.region
    row: 12
    col: 16
    width: 8
    height: 9
  filters:
  - name: Year to Date?
    title: Year to Date?
    type: field_filter
    default_value: 'Yes'
    allow_multiple_values: true
    required: false
    model: sales
    explore: order_info
    listens_to_filters: []
    field: order_info.ytd
  - name: Choose your Measure
    title: Choose your Measure
    type: field_filter
    default_value: sales
    allow_multiple_values: true
    required: false
    model: sales
    explore: order_info
    listens_to_filters: []
    field: order_info.choose_measure
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: sales
    explore: order_info
    listens_to_filters: []
    field: order_info.region
