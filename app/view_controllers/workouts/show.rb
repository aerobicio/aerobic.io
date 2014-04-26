require 'units_helper'

module Workouts
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    include ActionView::Helpers::TagHelper
    include UnitsHelper

    attr_reader :workout

    def initialize(controller, member_id, workout_id)
      @controller = controller
      @workout = Workout.find_by!(user_id: member_id, id: workout_id)
    end

    def cache_key
      @workout.cache_key
    end

    def duration
      format_duration(@workout.active_duration)
    end

    def distance
      format_distance(@workout.distance)
    end

    def member
      @workout.user
    end

    def title
      'My Workout Title'
    end

    def time_boundaries
      [
        @workout.start_time.to_formatted_s(:rfc822),
        content_tag(:i, '&rarr;'.html_safe, class: 'icon-rarr'),
        @workout.end_time.to_formatted_s(:rfc822)
      ].join(' ').html_safe
    end
  end
end
