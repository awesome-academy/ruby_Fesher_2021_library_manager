class Admin::RequestsController < AdminsController
  before_action :load_request, except: %i(index)

  def index
    @pagy, @requests = pagy Request.recent_post
  end

  def show; end

  def update
    if @request.update status: params[:request][:status]
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
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
