- dashboard: splash_demo_dashboard
  title: Splash Demo Dashboard
  layout: newspaper
  description: ''
  embed_style:
    background_color: "#f6f8fa"
    show_title: true
    title_color: "#3a4245"
    show_filters_bar: true
    tile_text_color: "#3a4245"
    text_tile_text_color: "#636061"
  elements:
  - name: Number of First Purchasers
    title: Number of First Purchasers
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.first_purchase_count
    sorts:
    - order_items.first_purchase_count desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: goal
      label: Goal
      expression: '10000'
      value_format:
      value_format_name: decimal_0
    query_timezone: America/Los_Angeles
    font_size: medium
    colors:
    - "#5245ed"
    - "#a2dcf3"
    - "#776fdf"
    - "#1ea8df"
    - "#49cec1"
    - "#776fdf"
    - "#49cec1"
    - "#1ea8df"
    - "#a2dcf3"
    - "#776fdf"
    - "#776fdf"
    - "#635189"
    text_color: black
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: New Users Acquired
    custom_color_enabled: true
    custom_color: "#683AE6"
    listen:
      Date: order_items.created_date
      Country: users.country
      State: users.state
      City: users.city
    note_state: collapsed
    note_display: above
    note_text: ''
    row: 6
    col: 0
    width: 6
    height: 4
  - name: Average Order Sale Price
    title: Average Order Sale Price
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.average_sale_price
    sorts:
    - orders.average_profit desc
    - order_items.average_sale_price desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: date
      label: date
      expression: now()
      value_format:
      value_format_name:
      _kind_hint: dimension
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: "#683AE6"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    font_size: medium
    text_color: black
    colors:
    - "#5245ed"
    - "#a2dcf3"
    - "#776fdf"
    - "#1ea8df"
    - "#49cec1"
    - "#776fdf"
    - "#49cec1"
    - "#1ea8df"
    - "#a2dcf3"
    - "#776fdf"
    - "#776fdf"
    - "#635189"
    series_types: {}
    listen:
      Date: order_items.created_date
      Country: users.country
      State: users.state
      City: users.city
    note_state: collapsed
    note_display: below
    note_text: ''
    row: 6
    col: 18
    width: 6
    height: 4
  - name: User Behaviors by Traffic Source
    title: User Behaviors by Traffic Source
    model: thelook_events
    explore: order_items
    type: looker_column
    fields:
    - users.traffic_source
    - order_items.average_sale_price
    - user_order_facts.average_lifetime_orders
    sorts:
    - user_order_facts.lifetime_orders_tier__sort_
    - users.traffic_source
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    hidden_fields:
    - percent_repeat_customers
    value_labels: legend
    label_type: labPer
    font_size: '13'
    colors:
    - "#683AE6"
    hide_legend: false
    y_axis_orientation:
    - left
    - right
    y_axis_value_format: '0'
    y_axis_labels:
    - Average Sale Price ($)
    show_null_points: true
    point_style: circle_outline
    interpolation: linear
    limit_displayed_rows: false
    y_axis_scale_mode: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors: {}
    listen:
      Date: order_items.created_date
      Country: users.country
    row: 17
    col: 0
    width: 16
    height: 7
  - name: User Basic Demographic Profile
    title: User Basic Demographic Profile
    model: thelook_events
    explore: order_items
    type: looker_donut_multiples
    fields:
    - users.gender
    - users.traffic_source
    - order_items.count
    pivots:
    - users.traffic_source
    filters:
      users.gender: "-NULL"
    sorts:
    - user_order_facts.lifetime_orders_tier__sort_
    - users.traffic_source
    - order_items.count desc 0
    limit: 500
    column_limit: 15
    query_timezone: America/Los_Angeles
    show_value_labels: true
    show_view_names: true
    font_size: 15
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    hide_legend: false
    colors:
    - "#FF0193"
    - "#683AE6"
    - "#00A8FF"
    - "#00CA86"
    - "#FFB21C"
    series_colors: {}
    listen:
      Date: order_items.created_date
      Country: users.country
    note_state: collapsed
    note_display: below
    note_text: ''
    row: 10
    col: 0
    width: 12
    height: 7
  - name: Total Order Count
    title: Total Order Count
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.reporting_period
    - order_items.count
    filters:
      order_items.reporting_period: "-NULL"
    sorts:
    - order_items.count desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: percent_change
      label: Percent Change
      expression: "${order_items.count}/offset(${order_items.count},1) - 1"
      value_format:
      value_format_name: percent_0
    query_timezone: America/Los_Angeles
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    colors:
    - "#5245ed"
    - "#a2dcf3"
    - "#776fdf"
    - "#1ea8df"
    - "#49cec1"
    - "#776fdf"
    - "#49cec1"
    - "#1ea8df"
    - "#a2dcf3"
    - "#776fdf"
    - "#776fdf"
    - "#635189"
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_single_value_title: true
    single_value_title: Orders This Year
    hidden_fields:
    - order_items.reporting_period
    comparison_label: vs Same Period Last Year
    custom_color_enabled: true
    custom_color: "#683AE6"
    listen:
      Country: users.country
      State: users.state
      City: users.city
    row: 6
    col: 12
    width: 6
    height: 4
  - name: ''
    type: text
    title_text: ''
    body_text: <img src="https://d24wuq6o951i2g.cloudfront.net/img/events/id/268/2688777/assets/e38.splash-grape-copy.png"
      height="150" width="475"/>
    row: 2
    col: 0
    width: 24
    height: 4
  - name: tsst
    type: text
    body_text: |-
      <font color="#683AE6" size="6">Text box</font>
      <font color="#00A8FF" size="18" >colors & sizes</font>
      <font color="#FF0193" size="6">can be changed in the UI</font>
    row: 17
    col: 16
    width: 8
    height: 7
  - title: New Tile
    name: New Tile
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.ui_label
    sorts:
    - order_items.ui_label
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 0
    col: 0
    width: 24
    height: 2
  - title: New Tile2
    name: New Tile2
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.lookml_label
    sorts:
    - order_items.lookml_label
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 26
    col: 0
    width: 24
    height: 2
  - title: New Tile3
    name: New Tile3
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.footer
    sorts:
    - order_items.footer
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 42
    col: 0
    width: 24
    height: 2
  - title: New Tile4
    name: New Tile4
    model: thelook_events
    explore: order_items
    type: single_value
    fields:
    - order_items.order_count_image
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 28
    col: 0
    width: 8
    height: 6
  - name: tst
    type: text
    body_text: "<br/>"
    row: 24
    col: 0
    width: 24
    height: 2
  - title: New Tile5
    name: New Tile5
    model: thelook_events
    explore: monthly_table
    type: single_value
    fields:
    - monthly_table.monthly_results_table
    sorts:
    - monthly_table.monthly_results_table
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 28
    col: 8
    width: 16
    height: 6
  - title: Top Customers
    name: Top Customers
    model: thelook_events
    explore: order_items
    type: table
    fields:
    - order_items.name_w_formatting
    - order_items.state_w_formatting
    - order_items.total_sales_w_formatting
    sorts:
    - order_items.total_sales_w_formatting desc
    limit: 10
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_labels:
      order_items.name_w_formatting: Customer Name
      order_items.state_w_formatting: Customer State
      order_items.total_sales_w_formatting: Total Order Value
    row: 34
    col: 0
    width: 24
    height: 8
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
  - name: Country
    title: Country
    type: field_filter
    default_value: "{{ _user_attributes['country'] }}"
    allow_multiple_values: true
    required: false
    model: thelook_events
    explore: order_items
    listens_to_filters: []
    field: users.country
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: thelook_events
    explore: order_items
    listens_to_filters:
    - Country
    field: users.state
  - name: City
    title: City
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: thelook_events
    explore: order_items
    listens_to_filters:
    - State
    - Country
    field: users.city
