class Admin::AuthorsController < AdminsController
  load_and_authorize_resource

  def index
    @pagy, @authors = pagy(Author.recent_added)
  end

  def new
    @author = Author.new
  end

  def show; end

  def edit; end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t ".success"
      redirect_to [:admin, @author]
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def update
    if @author.update author_params
      flash[:success] = t ".success"
      redirect_to [:admin, @author]
    else
      flash[:danger] = t ".fails"
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit Author::PROPERTIES
  end
end
