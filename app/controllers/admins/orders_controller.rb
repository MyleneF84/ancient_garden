class Admins::OrdersController < AdminsController
  before_action :set_admins_order, only: %i[ show edit update destroy ]

  def index
    @unfulfilled_orders = Order.where(fulfilled: false).order(created_at: :asc)
    @fulfilled_orders = Order.where(fulfilled: true).order(created_at: :asc)
  end

  def show
  end

  def new
    @admins_order = Order.new
  end

  def edit
  end

  def create
    @admins_order = Order.new(admins_order_params)
    if @admins_order.save
      redirect_to admins_order_path(@admins_order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admins_order.update(admins_order_params)
      redirect_to admins_order_path(@admins_order), notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admins_order.destroy
    redirect_to admins_orders_path, notice: "Order was successfully destroyed."
  end

  private
    def set_admins_order
      @admins_order = Order.find(params[:id])
    end

    def admins_order_params
      params.require(:order).permit(:customer_email, :address, :total, :fulfilled)
    end
end
