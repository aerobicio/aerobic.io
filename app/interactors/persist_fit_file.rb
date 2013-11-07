class PersistFitFile
  include Interactor

  def perform
    fit_file = context[:fit_file]
    fit_file.workout_id = context[:workout].id
    fit_file.save!
  end
end
