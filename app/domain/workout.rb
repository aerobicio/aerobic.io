require "active_support/core_ext/object/try"
require "active_support/json"

module Domain

  # Workouts are a high level summary of a processed FitFile.
  class Workout
    attr_reader :id
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

    private

    def extract_attributes(data_object)
      @id = data_object.try(:id)
      @active_duration = data_object.try(:active_duration)
      @distance = data_object.try(:distance)
      @duration = data_object.try(:duration)
      @end_time = data_object.try(:end_time)
      @start_time = data_object.try(:start_time)
    end
  end
end
