require 'activity'

class Activity
  class FollowedUser < Activity
    acts_as_commentable
  end
end
