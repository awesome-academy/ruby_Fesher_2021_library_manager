module SessionsHelper
  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in?
    user_signed_in?
  end

  def load_user_name
    current_user.name
  end

  def total_price books
    books.reduce(0){|a, e| a + e.price}
  end
end
