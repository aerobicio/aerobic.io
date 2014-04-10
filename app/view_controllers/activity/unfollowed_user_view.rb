class Activity
  # View Controller for managing the logic around rendering
  # /activity/followed_users/_followed_user
  class UnfollowedUserView
    include Rails.application.routes.url_helpers

    def initialize(context, current_member, unfollowed_member)
      @context = context
      @current_member = current_member
      @unfollowed_member = unfollowed_member
    end

    def cache_key
      [
        @current_member.cache_key,
        @unfollowed_member.cache_key
      ].map(&:to_s).join(':')
    end

    def unfollowing_member
      @unfollowed_member.activity_user
    end

    def unfollowed_member
      @unfollowed_member.activity_followed_user
    end

    def unfollowing_member_path
      member_path(id: unfollowing_member.id)
    end

    def unfollowed_member_path
      member_path(id: unfollowed_member.id)
    end

    def title
      [
        @context.link_to(I18n.t('activity.title.first_person'), unfollowing_member_path),
        I18n.t('activity.unfollowed_user.title'),
        @context.link_to(I18n.t('activity.title.third_person', name: unfollowed_member.name), unfollowed_member_path)
      ].join(' ').html_safe
    end
  end
end
