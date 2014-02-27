# An Organizer that handles the process of creating a workout from and uploaded
# FIT file.
#
class CreateWorkoutFromUploadedFitFile
  include Interactor::Organizer

  organize ProcessUploadedFitFile,
           CreateWorkoutFromActivityFile,
           AddWorkoutToActivityFeeds
end
