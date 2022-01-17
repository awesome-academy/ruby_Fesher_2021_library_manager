module LikesHelper
  def get_likes likeable
    current_user.likes.find_by likeable: likeable
  end
end
