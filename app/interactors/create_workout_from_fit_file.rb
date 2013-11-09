require "interactor"
require "ostruct"

require_relative "../domain/workout"

# Creates a Domain::Workout object from the FitFile object within the context.
#
# It persists the workout and assigned the workout id to the FitFile before
# saving it.
class CreateWorkoutFromFitFile
  include Interactor

  def perform
    @fit_file = context[:fit_file]

    workout = Domain::Workout.new(workout_data_object)
    workout.persist!
    @fit_file.workout_id = workout.id
    @fit_file.save!
  end

  private

  def workout_data_object
    OpenStruct.new( active_duration: @fit_file.active_duration,
                    distance: @fit_file.distance,
                    duration: @fit_file.duration,
                    end_time: @fit_file.end_time,
                    start_time: @fit_file.start_time,
                    user_id: context[:member_id]
                  )
  end
end
