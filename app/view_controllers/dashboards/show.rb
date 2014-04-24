require 'kaminari'

module Dashboards
  # View Controller for managing the logic around rendering /dashboards/show
  #
  class Show
    def initialize(controller, member, page = 1)
      @controller = controller
      @member = member
      @page = page
    end

    def cache_key
      activities.map(&:cache_key).join(':')
    end

    def render_activities
      if activities.any?
        @controller.render(partial: 'activity/grouped',
                           object: activities.group_by(&:date),
                           locals: { activities: activities }
                          ).first
      else
        'You have no activity!'
      end
    end

    private

    def activities
      @activities ||= member_activities.page(@page)
    end

    def member_activities
      @member.activities
    end
  end
end
