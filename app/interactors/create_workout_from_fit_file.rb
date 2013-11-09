require "interactor"
require "ostruct"

# Creates a Workout object from the FitFile object within the context.
#
# It persists the workout and assigned the workout id to the FitFile before
# saving it.
class CreateWorkoutFromFitFile
  include Interactor

  def perform
    @fit_file = context[:fit_file]

    workout = create_workout
    @fit_file.workout_id = workout.id
    @fit_file.save!
    context[:workout] = workout
  end

  private

  def create_workout
    Workout.create( active_duration: @fit_file.active_duration,
                    distance: @fit_file.distance,
                    duration: @fit_file.duration,
                    end_time: @fit_file.end_time,
                    start_time: @fit_file.start_time,
                    user_id: context[:member_id]
                  )
  end
end
