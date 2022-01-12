class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      if user.activated?
        log_in? user
      else

        flash[:warning] = t ".p1"
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
