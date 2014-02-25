class CreateWorkoutFromUploadedFitFile
  include Interactor::Organizer

  organize ProcessUploadedFitFile,
           CreateWorkoutFromActivityFile,
           AddWorkoutToActivityFeeds
end
