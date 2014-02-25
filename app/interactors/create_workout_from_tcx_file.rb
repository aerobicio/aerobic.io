require "interactor"

# Creates a Workout object from the TcxFile object within the context.
#
# It persists the workout and assigned the workout id to the TcxFile before
# saving it.
class CreateWorkoutFromTcxFile
  include Interactor

  def perform
    workout = create_workout
    tcxfile.workout_id = workout.id

    if workout.persisted? && tcxfile.save
      context[:workout] = workout
    else
      context.fail!
    end
  end

  private

  def create_workout
    Workout.create( uuid: workout_uuid(
                      context[:device_workout_id],
                      context[:device_id]
                    ),
                    device_id: context[:device_id],
                    device_workout_id: context[:device_workout_id],
                    active_duration: tcxfile.active_duration,
                    distance: tcxfile.distance,
                    duration: tcxfile.duration,
                    end_time: tcxfile.end_time,
                    start_time: tcxfile.start_time,
                    user_id: context[:member_id]
                  )
  end

  def workout_uuid(device_workout_id, device_id)
    Digest::SHA1.hexdigest("#{device_workout_id}:#{device_id}")
  end
end
