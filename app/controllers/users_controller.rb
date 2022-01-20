class UsersController < ApplicationController
  before_action :load_user

  def show
    @pagy, @requests = pagy @user.requests.recent_post
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "errors.user.not_found"
    redirect_to root_path
  end
end
