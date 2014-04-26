class Activity
  # View Controller for managing the logic around rendering
  # /activity/followed_users/_followed_user
  class UnfollowedUserView
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

    def title
      I18n.t('activity.title.html',
             member_link: unfollowing_member_link,
             verb: I18n.t('activity.unfollowed_user.title.verb'),
             action_link: unfollowed_member_link).html_safe
    end

    def unfollowing_member
      @unfollowed_member.activity_user
    end

    def unfollowed_member
      @unfollowed_member.activity_followed_user
    end

    def unfollowing_member_path
      url_helpers.member_path(id: unfollowing_member.id)
    end

    def unfollowed_member_path
      url_helpers.member_path(id: unfollowed_member.id)
    end

    private

    def unfollowing_member_link
      @context.link_to(unfollowing_member_title.capitalize_first_letter,
                       unfollowing_member_path)
    end

    def unfollowed_member_link
      @context.link_to(unfollowed_member_title, unfollowed_member_path)
    end

    def unfollowing_member_title
      unfollowing_member.name_in_context_of(@current_member)
    end

    def unfollowed_member_title
      unfollowed_member.name_in_context_of(@current_member)
    end

    # Wrap access to rails url helpers to avoid including them. This allows us
    # to stub them out during testing without requiring all of rails.
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
