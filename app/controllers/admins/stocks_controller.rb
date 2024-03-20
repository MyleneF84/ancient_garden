class Admins::StocksController < AdminsController
  before_action :set_admins_stock, only: %i[ show edit update destroy ]

  def index
    @admins_stocks = Stock.where(product_id: params[:product_id])
    @admins_product = Product.find(params[:product_id])
  end

  def show
    @admins_product = Product.find(params[:product_id])
  end

  def new
    @admins_product = Product.find(params[:product_id])
    @admins_stock = Stock.new
  end

  def edit
    @admins_product = Product.find(params[:product_id])
  end

  def create
    @admins_product = Product.find(params[:product_id])
    @admins_stock = Stock.new(admins_stock_params)
    @admins_stock.product = @admins_product
    if @admins_stock.save
      redirect_to admins_product_stock_path(@admins_product, @admins_stock), notice: "Stock was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @admins_product = Product.find(params[:product_id])
      if @admins_stock.update(admins_stock_params)
        redirect_to admins_product_stock_path(@admins_product, @admins_stock), notice: "Stock was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @admins_stock.destroy
    redirect_to admins_product_stocks_path, notice: "Stock was successfully destroyed."
  end

  private
    def set_admins_stock
      @admins_stock = Stock.find(params[:id])
    end

    def admins_stock_params
      params.require(:stock).permit(:size, :amount, :product_id)
    end
end
