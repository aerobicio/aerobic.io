require 'kaminari'

module Dashboards
  # View Controller for managing the logic around rendering /dashboards/show
  #
  class Show
    include UnitsHelper

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

    private

    def activities
      @activities ||= member_activities.page(@page)
    end

    def member_activities
      @member.activities
    end
  end
end
