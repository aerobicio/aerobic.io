require "interactor"
require "ostruct"

# Creates a Workout object from the FitFile object within the context.
#
# It persists the workout and assigned the workout id to the FitFile before
# saving it.
class CreateWorkoutFromFitFile
  include Interactor

  def perform
    workout = create_workout
    fitfile.workout_id = workout.id

    if workout.persisted? && fitfile.save
      context[:workout] = workout
    else
      context.fail!
    end
  end

  private

  def create_workout
    Workout.create( device_id: context[:device_id],
                    device_workout_id: context[:device_workout_id],
                    active_duration: fitfile.active_duration,
                    distance: fitfile.distance,
                    duration: fitfile.duration,
                    end_time: fitfile.end_time,
                    start_time: fitfile.start_time,
                    user_id: context[:member_id]
                  )
  end
end
