class Admin::RequestsController < AdminsController
  load_and_authorize_resource

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
end
