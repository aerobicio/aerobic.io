class Activity
  # View Controller for managing the logic around rendering
  # /activity/followed_users/_followed_user
  class FollowedUserView
    include Rails.application.routes.url_helpers

    def initialize(context, current_member, followed_member)
      @context = context
      @current_member = current_member
      @followed_member = followed_member
    end

    def cache_key
      [
        @current_member.cache_key,
        @followed_member.cache_key
      ].map(&:to_s).join(':')
    end

    def title
      [
        @context.link_to(following_member_title, following_member_path),
        I18n.t('activity.followed_user.title'),
        @context.link_to(followed_member_title, followed_member_path)
      ].join(' ').html_safe
    end

    def following_member
      @followed_member.activity_user
    end

    def followed_member
      @followed_member.activity_followed_user
    end

    def following_member_path
      member_path(id: following_member.id)
    end

    def followed_member_path
      member_path(id: followed_member.id)
    end

    private

    def following_member_title
      if @current_member == following_member
        I18n.t('activity.title.first_person')
      else
        I18n.t('activity.title.third_person', name: following_member.name)
      end
    end

    def followed_member_title
      if @current_member == followed_member
        I18n.t('activity.title.first_person')
      else
        I18n.t('activity.title.third_person', name: followed_member.name)
      end
    end
  end
end
