class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to admin_root_path if user.is_admin
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
