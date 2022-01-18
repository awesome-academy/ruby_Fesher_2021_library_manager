class AdminsController < ApplicationController
  before_action :authenticate_user!, :require_admin

  layout "admin"

  private
  def require_admin
    redirect_to root_url unless current_user.is_admin
  end
end
