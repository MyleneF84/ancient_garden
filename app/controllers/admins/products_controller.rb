class Admins::ProductsController < AdminsController
  before_action :set_admin_product, only: %i[ show edit update destroy ]

  def index
    @admins_products = Product.all
  end

  def show
  end

  def new
    @admins_product = Product.new
  end

  def edit
  end

  def create
    @admins_product = Product.new(admins_product_params)

    respond_to do |format|
      if @admins_product.save
        format.html { redirect_to admins_product_url(@admins_product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @admin_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @admins_product.update(admins_product_params.reject { |p| p["images"] })
      if admins_product_params["images"]
        admins_product_params["images"].each do |image|
          @admins_product.images.attach(image)
        end
      end
      redirect_to admins_product_path(@admins_product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @admins_product.destroy

    respond_to do |format|
      format.html { redirect_to admins_products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admins_product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admins_product_params
      params.require(:product).permit(:name, :description, :price, :category_id, :active, images: [])
    end
end
