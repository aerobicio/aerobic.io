class Activity
  # View Controller for managing the logic around rendering
  # /activity/added_workout/_added_workout
  #
  class AddedWorkoutView
    include UnitsHelper
    include Rails.application.routes.url_helpers

    def initialize(context, current_member, added_workout)
      @context = context
      @current_member = current_member
      @added_workout = added_workout
    end

    def cache_key
      [
        @added_workout.cache_key,
        @added_workout.activity_workout.cache_key
      ].map(&:to_s).join(':')
    end

    def title
      [
        @context.link_to(member_title, member_path(id: member.id)),
        I18n.t('activity.added_workout.action'),
        @context.link_to(I18n.t('activity.added_workout.object'), workout_path)
      ].join(' ').html_safe
    end

    def duration
      format_duration(workout.active_duration)
    end

    def distance
      format_distance(workout.distance)
    end

    def workout_path
      member_workout_path(member_id: member.id, id: workout.id)
    end

    def workout_member
      @added_workout.activity_user
    end

    private

    def member_title
      if @current_member == member
        I18n.t('activity.title.first_person')
      else
        I18n.t('activity.title.third_person', name: member.name)
      end
    end

    def member
      @added_workout.activity_user
    end

    def workout
      @added_workout.activity_workout
    end
  end
end
