class HandleFitFileUpload
  include Interactor::Organizer

  organize ProcessFitFile, CreateWorkoutFromFitFile, PersistFitFile
end
