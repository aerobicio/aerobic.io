module Members

  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    attr_reader :member

    def initialize(controller, current_member, member_id)
      @controller = controller
      @current_member = current_member
      @member = User.find(member_id)
    end

    def cache_key
      [
        @current_member.cache_key,
        @member.cache_key,
        activities.map(&:cache_key)
      ].flatten.join(":")
    end

    def render_activities
      if activities.any?
        @controller.render(partial: "activity/grouped",
                           object: activities.group_by(&:date)
                          ).first
      else
        "You have no activity!"
      end
    end

    private

    def activities
      @activities ||= member_activities
    end

    def member_activities
      if $switch_board.following_active?(@member)
        @member.activities
      else
        @member.activities.exclude_following
      end
    end
  end
end
