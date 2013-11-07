class CreateWorkoutFromFitFile
  include Interactor

  def perform
    fit_file = context[:fit_file]
    workout = Domain::Workout.new(workout_data_object(fit_file))
    workout.persist!
    context[:workout] = workout
  end

  def workout_data_object(fit_file)
    OpenStruct.new( active_duration: fit_file.active_duration,
                    distance: fit_file.distance,
                    duration: fit_file.duration,
                    end_time: fit_file.end_time,
                    start_time: fit_file.start_time,
                    user_id: context[:user].id,
                  )
  end
end
