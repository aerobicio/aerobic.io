require "i18n"
require_relative "../../helpers/units_helper"

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
        @current_member.cache_key,
      ].join(":")
    end

    def title
      if @current_member == member
        I18n.t("activity.workout.title.first_person")
      else
        I18n.t("activity.workout.title.third_person", name: member.name)
      end
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
      @workout.user
    end

    private

    def member
      @workout.user
    end

    def workout
      @workout
    end

    # Wrap access to rails url helpers to avoid including them. This allows us
    # to stub them out during testing without requiring all of rails.
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
