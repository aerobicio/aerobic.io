# An Organizer that handles the process of creating a workout from and uploaded
# TCX file.
#
class CreateWorkoutFromUploadedTcxFile
  include Interactor::Organizer

  organize ProcessUploadedTcxFile,
           CreateWorkoutFromActivityFile,
           AddWorkoutToActivityFeeds
end
