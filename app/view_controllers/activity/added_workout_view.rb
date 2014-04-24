require 'i18n'
require 'units_helper'

class Activity
  # View Controller for managing the logic around rendering
  # /activity/added_workout/_added_workout
  #
  class AddedWorkoutView
    include UnitsHelper

    def initialize(current_member, added_workout)
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
      I18n.t("activity.workout.title.#{sport}", name: name)
    end

    def duration
      format_duration(workout.active_duration)
    end

    def distance
      format_distance(workout.distance)
    end

    def workout_path
      url_helpers.member_workout_path(member_id: member.id, id: workout.id)
    end

    def workout_member
      @added_workout.activity_user
    end

    private

    def name
      if @current_member == member
        I18n.t('you')
      else
        member.name
      end
    end

    def sport
      workout.sport? ? workout.sport.downcase : 'default'
    end

    def member
      @added_workout.activity_user
    end

    def workout
      @added_workout.activity_workout
    end

    # Wrap access to rails url helpers to avoid including them. This allows us
    # to stub them out during testing without requiring all of rails.
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
