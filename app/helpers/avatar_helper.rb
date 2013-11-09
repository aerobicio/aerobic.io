module AvatarHelper
  def gravatar_for_member(member, size = 200)
    gravatar_id   = Digest::MD5.hexdigest(member.user.email.downcase)
    gravatar_path = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"

    content_tag :figure, class: "avatar" do
      image_tag(gravatar_path, class: "avatar__image")
    end
  end
end
