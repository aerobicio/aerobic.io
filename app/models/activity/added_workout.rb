require 'activity'

class Activity
  class AddedWorkout < Activity
    acts_as_commentable
  end
end
