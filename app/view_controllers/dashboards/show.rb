module Dashboards
  # View Controller for managing the logic around rendering /dashboards/show
  #
  class Show
    include UnitsHelper

    WeeklyTotals = Struct.new(:workouts, :duration, :distance, :tss)

    def initialize(controller, member)
      @controller = controller
      @member = member
    end

    def cache_key
      activities.map(&:cache_key).join(':')
    end

    def render_activities
      if activities.any?
        @controller.render(partial: 'activity/grouped',
                           object: activities.group_by(&:date)
                          ).first
      else
        'You have no activity!'
      end
    end

    def weekly_totals
      WeeklyTotals.new(
        @member.workouts.all.count,
        format_duration(62345635),
        format_distance(28131242),
        'XXX'
      )
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
