module UserHelper
  # Returns the gravatar for the given user
  def gravatar_for(user, size="100x100")
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: size)
  end
  
  # returns uploaded profile picture
  def profile_picture(user, size="100x100")
    # picture shows if it exists and has a URL
    image_tag(user.profile_picture, size: size) if user.profile_picture.url
  end
end
