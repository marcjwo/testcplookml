view: order_items {
  sql_table_name: `@{gcp_project}.@{bq_dataset}.order_items` ;;
  drill_fields: [order_item_id]
  fields_hidden_by_default: yes

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_item_id ;;
  }
  dimension: order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }
  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: product_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }
  dimension: quantity {
    hidden: no
    type: number
    sql: ${TABLE}.quantity ;;
  }
  # dimension: order_line_sales {
  #   hidden:yes
  #   type: number
  #   sql: ${quantity}*${price} ;;
  # }

  dimension: order_line_margin {
    hidden:yes
    type: number
    sql: ${price}-${cost} ;;
  }

  measure: count {
    type: count
    drill_fields: [order_item_id, products.product_id, products.product_name, orders.order_id]
  }

  measure: total_margin {
    hidden: no
    value_format_name: usd
    type: sum
    sql: ${order_line_margin} ;;
  }

  measure: total_sales {
    hidden: no
    value_format_name: usd
    type: sum
    sql: ${price} ;;
  }

  measure: total_cost {
    hidden: no
    value_format_name: usd
    type: sum
    sql: ${cost} ;;
  }

  measure: average_sales {
    hidden: no
    value_format_name: usd
    type: average
    sql: ${price} ;;
  }

  measure: total_quantity {
    hidden: no
    type: sum
    sql: ${quantity} ;;
  }

  measure: average_quantity {
    hidden: no
    type: average
    sql: ${quantity};;
  }
}
