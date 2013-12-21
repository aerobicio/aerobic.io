class Activity

  # View Controller for managing the logic around rendering
  # /activity/added_workout/_added_workout
  #
  class AddedWorkoutView
    def initialize(current_member, added_workout)
      @current_member = current_member
      @added_workout = added_workout
    end

    def cache_key
      [
        @added_workout.cache_key,
        @added_workout.activity_workout.cache_key,
      ].map(&:to_s).join(":")
    end

    def title
      if @current_member == member
        "You did a workout:"
      else
        "#{member.name} did a workout:"
      end
    end

    def duration
      "#{(workout.active_duration / 1000 / 60)} minutes"
    end

    def distance
      "#{(workout.distance / 100000.0).round(2)}km"
    end

    private

    def member
      @added_workout.activity_user
    end

    def workout
      @added_workout.activity_workout
    end
  end
end
