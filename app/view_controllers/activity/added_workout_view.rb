require 'i18n'
require 'units_helper'

class Activity
  # View Controller for managing the logic around rendering
  # /activity/added_workout/_added_workout
  #
  class AddedWorkoutView
    include UnitsHelper

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
      I18n.t('activity.title.html',
             member_link: name_link,
             verb: I18n.t('activity.added_workout.title.verb'),
             action_link: workout_link).html_safe
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

    def name_link
      @context.link_to(name.capitalize_first_letter, url_helpers.member_path(id: member.id))
    end

    def workout_link
      @context.link_to(
        I18n.t("activity.added_workout.title.#{sport}"),
        workout_path
      )
    end

    def name
      member.name_in_context_of(@current_member)
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
