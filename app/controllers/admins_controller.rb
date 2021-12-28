class AdminsController < ApplicationController
  before_action :require_admin

  layout "admin"

  private
  def require_admin
    redirect_to login_url unless current_user.is_admin?
  end
end