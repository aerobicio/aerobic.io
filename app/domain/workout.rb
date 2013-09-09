require "active_support/core_ext/object/try"

module Domain

  # Workouts are a high level summary of a processed FitFile.
  class Workout
    attr_reader :id
    attr_reader :user_id
    attr_accessor :active_duration, :distance, :duration, :end_time, :start_time

    def initialize(data_object)
      if data_object.is_a?(String)
        data_object = OpenStruct.new(JSON.parse(data_object))
      end
      extract_attributes(data_object)
    end

    def self.all_for(user_id)
      ::Workout.where(user_id: user_id).map do |workout|
        self.new(workout)
      end
    end

    def persist!
      workout = workout_record
      workout.active_duration = @active_duration
      workout.distance = @distance
      workout.duration = @duration
      workout.end_time = @end_time
      workout.start_time = @start_time
      workout.user_id = @user_id

      workout.save!
      @id = workout.id
      persist_to_redis(workout.created_at.to_i)
    end

    private

    def persist_to_redis(score)
      $redis.set(redis_key, to_json)
      User.all.each do |user|
        Domain::ActivityFeed.add_workout(user.id, score, redis_key)
      end
    end

    def to_json
      %!{"id":#{@id},
         "user_id":#{@user_id},
         "active_duration":#{@active_duration},
         "distance":#{@distance},
         "duration":#{@duration},
         "end_time":#{@end_time.to_i},
         "start_time":#{@start_time.to_i}
        }!
    end

    def workout_record
      ::Workout.new
    end

    def redis_key
      "user:#{@user_id}:workout:#{@id}"
    end

    def extract_attributes(data_object)
      @id = data_object.try(:id)
      @user_id = data_object.try(:user_id)

      [:active_duration, :distance, :duration,
        :end_time, :start_time].each do |attribute|
        send("#{attribute.to_s}=", data_object.try(attribute))
      end
    end
  end
end
