class Admin::CategoriesController < AdminsController
  before_action :load_category, except: %i(index new create)
  def index
    @pagy, @categories = pagy Category.recent_added
  end

  def new
    @category = Category.new
  end

  def show; end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to [:admin, @category]
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t ".success"
      redirect_to [:admin, @category]
    else
      flash[:danger] = t ".fails"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit Category::PROPERTIES
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t ".fail"
    redirect_to admin_root_path
  end
end
