module Workouts
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
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
  end
end
