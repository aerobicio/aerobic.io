require 'kaminari'

module Dashboards
  # View Controller for managing the logic around rendering /dashboards/show
  #
  class Show
    include UnitsHelper

    WeeklyTotals = Struct.new(:workouts, :duration, :distance, :tss)

    def initialize(context, member, page = 1)
      @context = context
      @member = member
      @page = page
    end

    def cache_key
      activities.map(&:cache_key).join(':')
    end

    def render_activities
      if activities.any?
        @context.render(partial: 'activity/grouped',
                        object: activities.group_by(&:date),
                        locals: { activities: activities }
                       )
      else
        I18n.t('activity.none.first_person')
      end
    end

    def render_activities_pagination
      @context.paginate(activities)
    end

    def weekly_totals
      WeeklyTotals.new(
        @member.workouts.all.count,
        format_duration(623_456_35),
        format_distance(281_312_42),
        'XXX'
      )
    end

    private

    def activities
      @activities ||= member_activities.page(@page)
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
