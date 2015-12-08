require 'activity'

class Activity
  # ActiveRecord object for storing Added Workout Activities
  #
  class AddedWorkout < Activity
    acts_as_commentable
  end
end
