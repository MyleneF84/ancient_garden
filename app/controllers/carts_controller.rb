class CartsController < ApplicationController
  def show
    puts @cart = params[:cart]

    # @order = Order.create!(customer_email: current_user.email, address: "123 jump street", total: params["total"] ,
    # fulfilled: false, user_id: current_user.id)

    # cart.each do |product|
    # @order_product = @order.order_products.build(product_id: product["id"])
    # end

  end
end
