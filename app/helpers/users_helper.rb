module UsersHelper
  def gravatar_for user, classes: "img", size: Settings.length.avatar_size
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img #{classes}")
  end
end
