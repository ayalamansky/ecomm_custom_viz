view: order_items {
  sql_table_name: order_items ;;
  ########## IDs, Foreign Keys, Counts ###########

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [detail*]
  }

  measure: order_count {
    view_label: "Orders"
    type: count_distinct
    drill_fields: [detail*]
    sql: ${order_id} ;;
  }


  measure: count_last_28d {
    label: "Count Sold in Trailing 28 Days"
    type: count_distinct
    sql: ${id} ;;
    hidden: yes
    filters:
    {field:created_date
      value: "28 days"
    }}

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;


    action: {
      label: "Send this to slack channel"
      url: "https://hooks.zapier.com/hooks/catch/1662138/tvc3zj/"

      param: {
        name: "user_dash_link"
        value: "https://demo.looker.com/dashboards/160?Email={{ users.email._value}}"
      }

      form_param: {
        name: "Message"
        type: textarea
        default: "Hey,
        Could you check out order #{{value}}. It's saying its {{status._value}},
        but the customer is reaching out to us about it.
        ~{{ _user_attributes.first_name}}"
      }

      form_param: {
        name: "Recipient"
        type: select
        default: "zevl"
        option: {
          name: "zevl"
          label: "Zev"
        }
        option: {
          name: "slackdemo"
          label: "Slack Demo User"
        }

      }

      form_param: {
        name: "Channel"
        type: select
        default: "cs"
        option: {
          name: "cs"
          label: "Customer Support"
        }
        option: {
          name: "general"
          label: "General"
        }

      }


    }



  }

  ########## Time Dimensions ##########

  dimension_group: returned {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [date, week, month, raw]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension_group: created {
    #X# group_label:"Order Date"
    type: time
    timeframes: [time, hour, date, week, month, year, hour_of_day, day_of_week, month_num, raw, week_of_year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: reporting_period {
    group_label: "Order Date"
    sql: CASE
        WHEN date_part('year',${created_raw}) = date_part('year',current_date)
        AND ${created_raw} < CURRENT_DATE
        THEN 'This Year to Date'

        WHEN date_part('year',${created_raw}) + 1 = date_part('year',current_date)
        AND date_part('dayofyear',${created_raw}) <= date_part('dayofyear',current_date)
        THEN 'Last Year to Date'

      END
       ;;
  }

  dimension: days_since_sold {
    hidden: yes
    sql: datediff('day',${created_raw},CURRENT_DATE) ;;
  }

  dimension: months_since_signup {
    view_label: "Orders"
    type: number
    sql: DATEDIFF('month',${users.created_raw},${created_raw}) ;;
  }

########## Logistics ##########

  dimension: status {
    sql: ${TABLE}.status ;;
  }

  dimension: days_to_process {
    type: number
    sql: CASE
        WHEN ${status} = 'Processing' THEN DATEDIFF('day',${created_raw},GETDATE())*1.0
        WHEN ${status} IN ('Shipped', 'Complete', 'Returned') THEN DATEDIFF('day',${created_raw},${shipped_raw})*1.0
        WHEN ${status} = 'Cancelled' THEN NULL
      END
       ;;
  }

  dimension: shipping_time {
    type: number
    sql: datediff('day',${shipped_raw},${delivered_raw})*1.0 ;;
  }

  measure: average_days_to_process {
    type: average
    value_format_name: decimal_2
    sql: ${days_to_process} ;;
  }

  measure: average_shipping_time {
    type: average
    value_format_name: decimal_2
    sql: ${shipping_time} ;;
  }

########## Financial Information ##########

  dimension: sale_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  dimension: gross_margin {
    type: number
    value_format_name: usd
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }

  dimension: item_gross_margin_percentage {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${gross_margin}/NULLIF(${sale_price},0) ;;
  }

  dimension: item_gross_margin_percentage_tier {
    type: tier
    sql: 100*${item_gross_margin_percentage} ;;
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
    style: interval
  }

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [detail*]
  }

  measure: total_gross_margin {
    type: sum
    value_format_name: usd
    sql: ${gross_margin} ;;
    drill_fields: [detail*]
  }

  measure: average_sale_price {
    type: average
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [detail*]
  }

  measure: median_sale_price {
    type: median
    value_format_name: usd
    sql: ${sale_price} ;;
    drill_fields: [detail*]
  }

  measure: average_gross_margin {
    type: average
    value_format_name: usd
    sql: ${gross_margin} ;;
    drill_fields: [detail*]
  }

  measure: total_gross_margin_percentage {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_gross_margin}/ NULLIF(${total_sale_price},0) ;;
  }

  measure: average_spend_per_user {
    type: number
    value_format_name: usd
    sql: 1.0 * ${total_sale_price} / NULLIF(${users.count},0) ;;
    drill_fields: [detail*]
  }

  measure: first_purchase_count {
      view_label: "Orders"
      type: count_distinct
      sql: ${order_id} ;;

      filters: {
        field: order_facts.is_first_purchase
        value: "Yes"
      }
      # customized drill path for first_purchase_count
      drill_fields: [user_id, order_id, created_date, users.traffic_source]
  }

########## Return Information ##########

  dimension: is_returned {
    type: yesno
    sql: ${returned_raw} IS NOT NULL ;;
  }

  measure: returned_count {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: is_returned
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: returned_total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    filters: {
      field: is_returned
      value: "yes"
    }
  }

  measure: return_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${returned_count} / nullif(${count},0) ;;
  }


########## Custom Formatting ##########

  dimension: ui_label {
    group_label: "Custom Formatting"
    sql: ${id} ;;
    html: <div style="padding-left:25px;padding-right:25px;">
                <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';background-color:##0079c1;color:#ffffff; font-size:16pt;font-weight:bold;vertical-align:middle;padding:5px,20px;height:75px;line-height:75px;text-align:left;">
                      <span style="width:200px;font-weight:400;font-weight:bold;">UI Customization</span>
                </div></div>
                ;;
  }

    dimension: ui_label_2 {
      group_label: "Custom Formatting"
      sql: ${id} ;;
      html: <div style="padding-left:25px;padding-right:25px;">
                <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';background-color:##0079c1;color:#ffffff; font-size:16pt;font-weight:bold;vertical-align:middle;padding:5px,20px;height:75px;line-height:75px;text-align:left;">
                      <span style="width:200px;font-weight:400;font-weight:bold;">Prompt Time to Transplant for U.S. Patients</span>
                </div></div>
                ;;
    }

  dimension: lookml_label {
    group_label: "Custom Formatting"
    sql: ${id} ;;
    html: <div style="padding-left:25px;padding-right:25px;">
                <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';background-color:##683AE6;color:#ffffff; font-size:16pt;font-weight:bold;vertical-align:middle;padding:5px,20px;height:75px;line-height:75px;text-align:left;">
                      <span style="width:200px;font-weight:400;font-weight:bold;">LookML Customization</span>
                </div></div>
                ;;
  }

  measure: order_count_image {
    group_label: "Custom Formatting"
    type: number
    hidden: no
    sql: ${order_count} ;;
    html: <img src="https://www.mapspeople.com/wp-content/themes/mapspeople/assets/icons/basket_size.svg" height=100>
              <div style="text-align:center;line-height:20pt; ">
                <br />
                <span style="font-family:'CentraleSansRnd', 'museo-sans-rounded';color: #683AE6; font-size:45pt;font-weight:bold;">{{ rendered_value }}</span>
                <br />
                <span style="font-family:'CentraleSansRnd', 'museo-sans-rounded';color:#4d4d4f;font-size:14pt;font-weight:700">Order Count</span>
              </div>
              ;;
  }

  dimension: name_w_formatting {
    group_label: "Custom Formatting"
    label: "Customer Name"
    sql: ${users.name} ;;
    html: <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';text-align:left;width:500px;"><span style="color: #4d4d4f; font-size:12pt;font-weight:450;padding-left:10px">{{ rendered_value }}</span></div>
      ;;
  }

  dimension: state_w_formatting {
    group_label: "Custom Formatting"
    label: "State"
    sql: ${users.state} ;;
    html: <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';text-align:left;width:300px;"><span style="color: #4d4d4f; font-size:12pt;font-weight:400;padding-left:10px;">{{ rendered_value }}</span></div>
      ;;
  }

  measure: total_sales_w_formatting {
    group_label: "Custom Formatting"
    label: "Total Order Value"
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
    html: <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';text-align:left;width:300px"><span style="color: #4d4d4f; font-size:12pt;font-weight:400;padding-left:5px;padding-right:200px;">{{ rendered_value }}</span></div>
      ;;
  }


    dimension: footer {
      group_label: "Custom Formatting"
      type: string
      sql: ${id} ;;
      html: <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';background-color:#ffffff;color:#4d4d4f; font-size:10pt;font-weight:300;padding:50px;">
          <table width=100%;><tr>
            <td style="text-align:left;">
              <span style='font-weight:bold'>This is a footer</span><br />
              containing any info/formatting I want<p /><p />
            </td>
            <td style="width:200px;text-align:right;">
              Page #
            </td>
          </tr></table>
      </div>
      ;;
    }

########## Sets ##########

  set: detail {
    fields: [id, order_id, status, created_date, sale_price, products.brand, products.item_name, users.portrait, users.name, users.email]
  }
  set: return_detail {
    fields: [id, order_id, status, created_date, returned_date, sale_price, products.brand, products.item_name, users.portrait, users.name, users.email]
  }
}
