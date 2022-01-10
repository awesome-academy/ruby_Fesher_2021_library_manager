class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(show)
  before_action :load_user, only: %i(show)

  def show
    @pagy, @requests = pagy @user.requests.recent_post
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "error.user.not_found"
    redirect_to help_url
  end
end
