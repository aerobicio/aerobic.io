require 'i18n'
require 'units_helper'

module Workouts
  # View Controller for managing the logic around rendering
  # /workouts/_workout
  #
  class WorkoutPartialView
    include UnitsHelper

    def initialize(current_member, workout)
      @current_member = current_member
      @workout = workout
    end

    def cache_key
      [
        @workout.cache_key,
        @current_member.cache_key
      ].join(':')
    end

    def title
      I18n.t("activity.workout.title.#{sport}", name: name)
    end

    def duration
      format_duration(@workout.active_duration)
    end

    def distance
      format_distance(@workout.distance)
    end

    def workout_path
      url_helpers.member_workout_path(member_id: member.id, id: @workout.id)
    end

    def workout_member
      @workout.user
    end

    private

    def name
      member.name_in_context_of(@current_member)
    end

    def sport
      @workout.sport? ? @workout.sport.downcase : 'default'
    end

    def member
      @workout.user
    end

    # Wrap access to rails url helpers to avoid including them. This allows us
    # to stub them out during testing without requiring all of rails.
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
