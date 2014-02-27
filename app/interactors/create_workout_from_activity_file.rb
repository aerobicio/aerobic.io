require 'interactor'

# Creates a Workout object from the activity_file object within the context.
#
# It persists the workout and assigned the workout id to the activity_file
# before saving it.
class CreateWorkoutFromActivityFile
  include Interactor

  def perform
    creator = WorkoutCreator.new(member_id,
                                 device_id,
                                 device_workout_id,
                                 activity_file)

    workout = creator.persist_workout
    activity_file.workout_id = workout.id

    if workout.persisted? && activity_file.save
      context[:workout] = workout
    else
      context.fail!
    end
  end
end
