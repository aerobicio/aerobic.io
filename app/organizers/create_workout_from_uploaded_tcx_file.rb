class CreateWorkoutFromUploadedTcxFile
  include Interactor::Organizer

  organize ProcessUploadedTcxFile,
           CreateWorkoutFromTcxFile,
           AddWorkoutToActivityFeeds
end
