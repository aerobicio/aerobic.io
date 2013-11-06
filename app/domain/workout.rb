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

    def persist!
      workout = workout_record

      workout.save!
      @id = workout.id
      @updated_at = workout.updated_at
      persist_to_activity_feeds
    end

    private

    def persist_to_activity_feeds
      user = User.find(@user_id)
      Activity::AddedWorkout.create(user_id: @user_id,
                                    activity_user_id: @user_id,
                                    activity_workout_id: @id)


      user.followers.each do |follower|
      Activity::AddedWorkout.create(user_id: follower.id,
                                    activity_user_id: @user_id,
                                    activity_workout_id: @id)
      end
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
  end
end
