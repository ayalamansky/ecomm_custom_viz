view: monthly_table {
  derived_table: {
    sql: SELECT
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Dresses')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.order_id  ELSE NULL END) AS "order_items.this_month_order_count_dresses",
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Pants')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.order_id  ELSE NULL END) AS "order_items.this_month_order_count_pants",
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Sweaters')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.order_id  ELSE NULL END) AS "order_items.this_month_order_count_sweaters",
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Dresses')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.user_id  ELSE NULL END) AS "order_items.this_month_user_count_dresses",
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Pants')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.user_id  ELSE NULL END) AS "order_items.this_month_user_count_pants",
        COUNT(DISTINCT CASE WHEN (((TRIM(products.category)) = 'Sweaters')) AND ((((order_items.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())))))) AND (order_items.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(month,1, DATE_TRUNC('month', DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE()))) ))))))) THEN order_items.user_id  ELSE NULL END) AS "order_items.this_month_user_count_sweaters"
      FROM order_items  AS order_items
      FULL OUTER JOIN inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
      LEFT JOIN products  AS products ON products.id = inventory_items.product_id ;;
  }
  dimension: this_month_order_count_dresses {
    type: number
    sql: ${TABLE}."order_items.this_month_order_count_dresses" ;;
  }

  dimension: this_month_order_count_pants {
    type: number
    sql: ${TABLE}."order_items.this_month_order_count_pants" ;;
  }

  dimension: this_month_order_count_sweaters {
    type: number
    sql: ${TABLE}."order_items.this_month_order_count_sweaters" ;;
  }

  dimension: this_month_user_count_dresses {
    type: number
    sql: ${TABLE}."order_items.this_month_user_count_dresses" ;;
  }

  dimension: this_month_user_count_pants {
    type: number
    sql: ${TABLE}."order_items.this_month_user_count_pants" ;;
  }

  dimension: this_month_user_count_sweaters {
    type: number
    sql: ${TABLE}."order_items.this_month_user_count_sweaters" ;;
  }

  dimension: monthly_results_table {
    group_label: "Custom Formatting"
    label: "Monthly Results Table"
    type: string
    hidden: no
    sql: 1 ;;
    html: <div style="font-family:'CentraleSansRnd', 'museo-sans-rounded';color:#4d4d4f; font-size:12pt;font-weight:400;padding-top:15px;padding-bottom:15px;padding-left:25px;padding-right:25px;">
              <table style="width:100%;border:none;border-collapse:collapse;" cellspacing="0" cellpadding="0">

                <tr style="background-color:#683AE6;color:#ffffff;font-size:12pt;font-weight:bold;height:75px;">
                  <td style="background-color:#683AE6;color:#ffffff;width:25%;border-right:3px solid white;text-align:center" align="center" >
                    Monthly Results
                  </td>
                  <td style="color:#ffffff;width:25%;border-right:3px solid white;text-align:center" align="center">
                    Orders
                  </td>
                  <td style="color:#ffffff;width:25%;border-right:3px solid white;text-align:center" align="center">
                    Customers
                  </td>
                </tr>

                <tr style="height:60px;padding:5px;">
                  <td style="border-right:3px solid white;" align="center">
                    <table style="width:100%;"><tr>
                        <td style="width:40%;text-align:right"><img src="https://thisbugslifedotcom.files.wordpress.com/2013/05/pants.png?w=366&h=428" height=50></td>
                        <td style="width:60%;text-align:left;padding-left:10px">&emsp;Pants</td>
                    </tr></table>
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_order_count_pants._value }}
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_user_count_pants._value }}
                  </td>
                </tr>

                <tr style="height:60px;padding:5px;background-color:#dcddde;">
                  <td style="border-right:3px solid white;" align="center">
                    <table style="width:100%;"><tr>
                        <td style="width:40%;text-align:right"><img src="http://www.clker.com/cliparts/2/L/n/o/1/C/pink-dress-hi.png" height=50></td>
                        <td style="width:60%;text-align:left;padding-left:10px">&emsp;Teachers</td>
                    </tr></table>
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_order_count_dresses._value }}
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_user_count_pants._value }}
                  </td>
                </tr>

                <tr style="height:60px;">
                  <td style="border-right:3px solid white;" align="center">
                    <table style="width:100%;"><tr>
                        <td style="width:40%;text-align:right"><img src="https://i.pinimg.com/564x/4f/4f/e6/4f4fe6e6626e7b5b5014c6abffd3c0bc.jpg" height=50></td>
                        <td style="width:60%;text-align:left;padding-left:10px">&emsp;Schools</td>
                    </tr></table
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_order_count_sweaters._value }}
                  </td>
                  <td style="border-right:3px solid white;text-align:center" align="center">
                    {{ this_month_user_count_pants._value }}
                  </td>
                </tr>

              </table>
              </div>
              ;;
  }
}
