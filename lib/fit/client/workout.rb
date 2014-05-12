require 'fit/client/service'

module Fit
  module Client
    # Fit::Client::Workout provices access to the aerobic.io fit-service.
    #
    class Workout
      attr_accessor :device_id, :device_workout_id, :fit_file, :member_id
      attr_accessor :distance, :active_duration, :duration, :end_time
      attr_accessor :start_time, :id, :workout_uuid, :sport

      def self.create(device_id, device_workout_id, fit_file, member_id)
        workout = new(device_id, device_workout_id, fit_file, member_id)
        workout.persist!
        workout
      end

      def initialize(device_id, device_workout_id, fit_file, member_id)
        @device_id = device_id
        @device_workout_id = device_workout_id
        @fit_file = fit_file
        @member_id = member_id
      end

      def persist!
        response = persist_fit_file_with_service

        @id = response['id']
        @distance = response['distance'] * 100
        @duration = response['duration'] * 1000
        @active_duration = response['active_duration'] * 1000
        @workout_uuid = response['uuid']
        @end_time = Time.zone.parse(response['end_time'])
        @start_time = Time.zone.parse(response['start_time'])
        @sport = response['sport']
      end

      private

      def persist_fit_file_with_service
        params = { device_id: device_id,
                   device_workout_id: device_workout_id,
                   fit_file: fit_file,
                   member_id: member_id }
        service = Fit::Client::Service.new
        service.post('/v1/workouts', params)
      end
    end
  end
end
