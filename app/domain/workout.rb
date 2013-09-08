require "active_support/core_ext/object/try"
require "active_support/json"

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
      $redis.set(redis_key, as_json)
    end

    private

    def workout_record
#      if @id
#        ::Workout.find(@id)
#      else
        ::Workout.new
#      end
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
