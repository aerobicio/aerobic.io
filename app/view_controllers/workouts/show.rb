module Workouts

  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    attr_reader :workout

    def initialize(controller, current_member, workout_id)
      @controller = controller
      @current_member = current_member
      @workout = Workout.find_by(user_id: current_member.id, id: workout_id)
    end

    def cache_key
      [
        @current_member.cache_key,
        @member.cache_key,
        activities.map(&:cache_key)
      ].flatten.join(":")
    end
  end
end
