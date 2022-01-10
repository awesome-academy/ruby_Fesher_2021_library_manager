class Admin::RequestsController < AdminsController
  before_action :load_request, except: %i(index)

  def index
    @pagy, @requests = pagy Request.recent_post
  end

  def show; end

  def update
    if @request.update(status: params[:request][:status]) &&
       [:rejected, :returned]
       .include?(params[:request][:status].to_sym)
      Book.find_by(id: @request.book_id).returned_book
      flash[:success] = t ".success"
    else
      flash[:info] = t ".fail"
    end
    redirect_to admin_requests_path
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request

    flash[:danger] = t ".load_fail"
    redirect_to admin_root_path
  end
end
