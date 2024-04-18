class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    address = event.data.object.customer_details.address.as_json
              .fetch_values("line1", "postal_code", "city", "country").join(" ")
    order.update(state: "paid", address: address)

    items = order.order_products
    items.each do |item|
      stock = Stock.find_by(product: item.product, size: item.size)
      new_stock = stock.amount - item.quantity
      stock.update(amount: new_stock)
    end
  end
end
