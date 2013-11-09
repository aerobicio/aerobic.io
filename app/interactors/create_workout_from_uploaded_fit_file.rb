class CreateWorkoutFromUploadedFitFile
  include Interactor::Organizer

  organize ProcessUploadedFitFile,
           CreateWorkoutFromFitFile
end
