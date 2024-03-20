class Admins::CategoriesController < AdminsController
  before_action :set_admins_category, only: %i[ show edit update destroy ]

  def index
    @admins_categories = Category.all
  end

  def show
  end

  def new
    @admins_category = Category.new
  end

  def edit
  end

  def create
    @admins_category = Category.new(admins_category_params)
    if @admins_category.save
      redirect_to admins_category_path(@admins_category), notice: "Category was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admins_category.update(admins_category_params)
      redirect_to admins_category_path(@admins_category), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admins_category.destroy
    redirect_to admins_categories_path, notice: "Category was successfully destroyed."
  end

  private
    def set_admins_category
      @admins_category = Category.find(params[:id])
    end

    def admins_category_params
      params.require(:category).permit(:name, :description, :image)
    end
end
