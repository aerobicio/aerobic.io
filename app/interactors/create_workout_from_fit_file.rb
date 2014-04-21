require 'interactor'

# Creates a Workout object from the activity_file object within the context.
#
# It persists the workout and assigned the workout id to the activity_file
# before saving it.
class CreateWorkoutFromFitFile
  include Interactor

  def perform
    workout = Fit::Client::Workout.create(device_id,
                                          device_workout_id,
                                          activity,
                                          member_id)

    if Workout.find_by_id(workout.id)
      context[:workout] = Workout.find_by_id(workout.id)
      context[:workout].update_attributes(workout_attributes(workout))
    else
      context[:workout] = Workout.create(workout_attributes(workout))
    end
  end

  private

  def workout_attributes(workout)
    {
      uuid: workout.workout_uuid,
      device_id: device_id,
      device_workout_id: device_workout_id,
      active_duration: workout.active_duration,
      distance: workout.distance,
      duration: workout.duration,
      end_time: workout.end_time,
      start_time: workout.start_time,
      user_id: member_id
    }
  end
end
