class Admins::ProductsController < AdminsController
  before_action :set_admin_product, only: %i[ show edit update destroy ]

  def index
    @admins_products = Product.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR description ILIKE :query"
      @admins_products = @admins_products.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
  end

  def new
    @admins_product = Product.new
    Product::SIZES.each { |size| @admins_product.product_prices.build(size: size) }
  end

  def edit
    @admins_product = Product.find(params[:id])
    Product::SIZES.each { |size| @admins_product.product_prices.build(size: size) } if @admins_product.product_prices.empty?
  end

  def create
    @admins_product = Product.new(admins_product_params)
      if @admins_product.save
        redirect_to admins_product_path(@admins_product), notice: "Product was successfully created."
      else
        render :new, status: :unprocessable_entity
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

  def destroy
    @admins_product.destroy
    redirect_to admins_products_path, notice: "Product was successfully destroyed."
  end

  def delete_image_attachement
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    # head :ok
  end

  private
    def set_admin_product
      @admins_product = Product.find(params[:id])
    end

    def admins_product_params
      params.require(:product).permit(:name, :description, :price, :category_id, :active, product_prices_attributes: [:id, :size, :price], images: [])
    end
end
