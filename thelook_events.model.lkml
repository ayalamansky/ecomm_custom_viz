connection: "thelook_events"
label: "1) eCommerce with Event Data"
include: "*.view" # include all the views
include: "*.dashboard" # include all the dashboards


explore: order_items {
  label: "(1) Orders, Items and Users"
  view_name: order_items
  join: inventory_items {
    #Left Join only brings in items that have been sold as order_item
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }

  join: users {
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: products {
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

}

explore: monthly_table {}
