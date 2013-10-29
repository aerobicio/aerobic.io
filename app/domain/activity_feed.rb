require_relative "workout"
require_relative "following"

module Domain

  # ActivityFeed represents a reverse chronological view of what has happened
  # in aerobic.io.
  module ActivityFeed
    module_function

    def add_activity(user_id, score, activity_key)
      $redis.zadd(redis_key(user_id), score, activity_key)
    end

    def activities(user_id)
      activities = $redis.zrevrange(redis_key(user_id), 0, -1)
      activities.map { |activity| instantiate_activity_model($redis.get(activity)) }
    end

    def redis_key(user_id)
      "user:#{user_id}:activity"
    end

    def instantiate_activity_model(activity)
      activity = OpenStruct.new(JSON.parse(activity))

      case activity.type
      when "following"
        Domain::Following.new(activity)
      else
        Domain::Workout.new(activity)
      end
    end
  end
end
