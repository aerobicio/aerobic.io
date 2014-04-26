# AvatarHelper is responsible for presenting various size gravatars based on
# Member email addresses
#
module AvatarHelper
  GRAVATAR_URL = '//gravatar.com/avatar/'
  GRAVATAR_DIMENSIONS = {
    small: 32,
    normal: 64,
    large:  164
  }

  def gravatar_for_member(member, options = {})
    options = { size: :normal, extra_classes: '' }.merge(options)
    classes = classes_for_avatar(options[:size], options[:extra_classes])

    content_tag :figure, class: classes do
      image_tag(gravatar_url(member, options[:size]), class: 'avatar__image')
    end
  end

  private

  def classes_for_avatar(size, extra_classes)
    classes = []
    classes << "#{avatar_class_for_size(size)}"
    classes << "#{extra_classes}"
    classes.map(&:strip).reject(&:empty?).join(' ')
  end

  def avatar_class_for_size(size = :normal)
    if size == :normal
      'avatar'
    elsif size == :small
      'avatar--small'
    elsif size == :large
      'avatar--large'
    end
  end

  def dimension_for_size(size)
    GRAVATAR_DIMENSIONS[size]
  end

  def gravatar_url(member, size)
    gravatar_id   = gravatar_id(member.email)
    gravatar_size = dimension_for_size(size)

    "#{GRAVATAR_URL}#{gravatar_id}.png?s=#{gravatar_size}"
  end

  def gravatar_id(email)
    Digest::MD5.hexdigest(email.downcase)
  end
end
