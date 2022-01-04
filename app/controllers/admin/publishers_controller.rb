class Admin::PublishersController < AdminsController
  before_action :load_publisher, except: %i(index new create)
  def index
    @pagy, @publishers = pagy Publisher.recent_added
  end

  def new
    @publisher = Publisher.new
  end

  def show; end

  def edit; end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t ".success"
      redirect_to [:admin, @publisher]
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def update
    if @publisher.update publisher_params
      flash[:success] = t ".success"
      redirect_to [:admin, @publisher]
    else
      flash[:danger] = t ".fails"
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_publishers_path
  end

  private

  def publisher_params
    params.require(:publisher).permit Publisher::PROPERTIES
  end

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher

    flash[:danger] = t ".fail"
    redirect_to admin_root_path
  end
end
