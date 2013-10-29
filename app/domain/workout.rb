require_relative "shared/initialize_from_data_object"

module Domain
  # Workouts are a high level summary of a processed FitFile.
  class Workout
    include Domain::Shared::InitializeFromDataObject

    attr_reader :id
    attr_reader :user_id
    attr_accessor :active_duration, :distance, :duration, :end_time, :start_time
    attr_accessor :updated_at

    def self.all_for(user_id)
      ::Workout.where(user_id: user_id).map do |workout|
        self.new(workout)
      end
    end

    def cache_key
      "domain:workout:#{id}:#{updated_at}"
    end

    def to_partial_path
      "workouts/workout"
    end

    def persist!
      workout = workout_record

      workout.save!
      @id = workout.id
      @updated_at = workout.updated_at
      persist_to_redis(workout.created_at.to_i)
    end

    private

    def persist_to_redis(score)
      $redis.pipelined do
        $redis.set(redis_key, to_json)
        user = User.find(@user_id)
        Domain::ActivityFeed.add_activity(user.id, score, redis_key)

        user.followers.each do |follower|
          Domain::ActivityFeed.add_activity(follower.id, score, redis_key)
        end
      end
    end

    def to_json
      %!{"id":#{@id},
         "user_id":#{@user_id},
         "active_duration":#{@active_duration},
         "distance":#{@distance},
         "duration":#{@duration},
         "end_time":#{@end_time.to_i},
         "start_time":#{@start_time.to_i},
         "updated_at":#{@updated_at.to_i}
        }!
    end

    def workout_record
      workout = ::Workout.new
      workout.active_duration = @active_duration
      workout.distance = @distance
      workout.duration = @duration
      workout.end_time = @end_time
      workout.start_time = @start_time
      workout.user_id = @user_id
      workout
    end

    def redis_key
      "user:#{@user_id}:workout:#{@id}"
    end
  end
end
