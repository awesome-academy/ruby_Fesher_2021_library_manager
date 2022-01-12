module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def log_in? user
    log_in user
    return redirect_to admin_root_path if user.is_admin

    redirect_back_or user
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id

      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user? user
    user && user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "errors.user.please_login"
    redirect_to login_url
  end

  def load_user_name
    current_user.name
  end
end
