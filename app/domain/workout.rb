require "active_support/core_ext/object/try"

module Domain

  # Workouts are a high level summary of a processed FitFile.
  class Workout
    attr_reader :id
    attr_accessor :active_duration, :distance, :duration, :end_time, :start_time

    def initialize(data_object)
      @id = data_object.try(:id)
      @active_duration = data_object.try(:active_duration)
      @distance = data_object.try(:distance)
      @duration = data_object.try(:duration)
      @end_time = data_object.try(:end_time)
      @start_time = data_object.try(:start_time)
    end

    def self.all_for(user_id)
      ::Workout.find_all_by_user_id(user_id).map do |workout|
        self.new(workout)
      end
    end
  end
end
