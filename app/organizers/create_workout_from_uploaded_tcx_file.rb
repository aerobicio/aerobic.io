class CreateWorkoutFromUploadedTcxFile
  include Interactor::Organizer

  organize ProcessUploadedTcxFile,
           CreateWorkoutFromActivityFile,
           AddWorkoutToActivityFeeds
end
