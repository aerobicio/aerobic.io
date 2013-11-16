module Dashboards

  # View Controller for managing the logic around rendering /dashboards/show
  #
  class Show
    def initialize(controller, member)
      @controller = controller
      @member = member
    end

    def cache_key
      activities.map(&:cache_key).join(":")
    end

    def activities
      @activities ||= @member.activities
    end

    def render_activities
      if activities.any?
        @controller.render(activities).first
      else
        "You have no activity!"
      end
    end
  end
end
