module AvatarHelper
  GRAVATAR_URL = "http://gravatar.com/avatar/"
  GRAVATAR_DIMENSIONS = {
    normal: 64,
    large:  164
  }

  def gravatar_for_member(member, options = {})
    options = {size: :normal, extra_classes: ''}.merge(options)

    content_tag :figure, class: "avatar #{options[:extra_classes]}" do
      image_tag(gravatar_url(member, options[:size]), class: "avatar__image")
    end
  end

  private

  def dimension_for_size(size)
    GRAVATAR_DIMENSIONS[size]
  end

  def gravatar_url(member, size)
    gravatar_id   = gravatar_id(member)
    gravatar_size = dimension_for_size(size)

    "#{GRAVATAR_URL}#{gravatar_id}.png?s=#{gravatar_size}"
  end

  def gravatar_id(member)
    Digest::MD5.hexdigest(member.email.downcase)
  end
end
