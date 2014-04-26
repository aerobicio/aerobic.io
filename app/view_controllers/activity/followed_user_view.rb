class Activity
  # View Controller for managing the logic around rendering
  # /activity/followed_users/_followed_user
  class FollowedUserView
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
      I18n.t('activity.title.html',
             member_link: following_member_link,
             verb: I18n.t('activity.followed_user.title.verb'),
             action_link: followed_member_link).html_safe
    end

    def following_member
      @followed_member.activity_user
    end

    def followed_member
      @followed_member.activity_followed_user
    end

    def following_member_path
      url_helpers.member_path(id: following_member.id)
    end

    def followed_member_path
      url_helpers.member_path(id: followed_member.id)
    end

    private

    def following_member_link
      @context.link_to(following_member_title.capitalize_first_letter,
                       following_member_path)
    end

    def followed_member_link
      @context.link_to(followed_member_title, followed_member_path)
    end

    def following_member_title
      following_member.name_in_context_of(@current_member)
    end

    def followed_member_title
      followed_member.name_in_context_of(@current_member)
    end

    # Wrap access to rails url helpers to avoid including them. This allows us
    # to stub them out during testing without requiring all of rails.
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
