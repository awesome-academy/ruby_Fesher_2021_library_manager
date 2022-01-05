class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      if user.is_admin
        redirect_to admin_root_path
      else
        redirect_to root_path
      end

    else
      flash[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
