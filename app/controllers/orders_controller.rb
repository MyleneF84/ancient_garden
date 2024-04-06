class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    puts cart = params[:cart]

    @order = Order.create!(customer_email: current_user.email, address: "123 jump street", total: params[:total] ,
    fulfilled: false, user_id: current_user.id)

    cart.each do |product|
    OrderProduct.create!(order_id: @order.id, product_id: product["id"], size: product["size"], quantity: product["quantity"])
    end


    line_items = cart.map do |item|
      product = Product.find(item["id"])
      product_stock = product.stocks.find{ |ps| ps.size == item["size"] }

      if product_stock.amount < item["quantity"].to_i
        render json: { error: "Not enough stock for #{product.name} in size #{item["size"]}. Only #{product_stock.amount} left." }, status: 400
        return
      end

      {
        quantity: item["quantity"].to_i,
        price_data: {
          product_data: {
            name: item["name"],
            metadata: { product_id: product.id, size: item["size"], product_stock_id: product_stock.id }
          },
          currency: "usd",
          unit_amount: (item["price"] * 100).to_i
        }
      }
    end

    # puts "#{line_items}"

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: success_url,
      cancel_url: "http://localhost:3000/cancel",
      shipping_address_collection: {
        allowed_countries: ['US', 'CA']
      }
    )

    @order.update!(checkout_session_id: session.id)

    render json: { url: session.url }

    # redirect_to order_path(@order)
  end



  private

  def order_params
    params.require(:order).permit(:customer_email, :address, :total, :fulfilled, :state, :user_id, :checkout_session_id)
  end

end
