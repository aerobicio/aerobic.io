require 'i18n'
require 'units_helper'

module Workouts
  # View Controller for managing the logic around rendering
  # /workouts/_workout
  #
  class WorkoutPartialView
    include UnitsHelper
    include Rails.application.routes.url_helpers

    def initialize(context, current_member, workout)
      @context = context
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
      [
        @context.link_to(member_title, member_path(id: member.id)),
        I18n.t('workouts.title.action'),
        @context.link_to(I18n.t('workouts.title.object'), workout_path)
      ].join(' ').html_safe
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

    def member_title
      if @current_member == member
        I18n.t('workouts.title.first_person')
      else
        I18n.t('workouts.title.third_person', name: member.name)
      end
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
