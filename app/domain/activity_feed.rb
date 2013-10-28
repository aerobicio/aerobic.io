require_relative "workout"

module Domain

  # ActivityFeed represents a reverse chronological view of what has happened
  # in aerobic.io.
  module ActivityFeed
    module_function

    def add_workout(user_id, score, workout_key)
      $redis.zadd(redis_key(user_id), score, workout_key)
    end

    def workouts(user_id)
      workouts = $redis.zrevrange(redis_key(user_id), 0, -1)
      workouts.map { |workout| Domain::Workout.new($redis.get(workout)) }
    end

    def redis_key(user_id)
      "user:#{user_id}:activity"
    end
  end
end
