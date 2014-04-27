require 'activity'

class Activity
  # ActiveRecord object for storing Following User Activities
  #
  class FollowedUser < Activity
    acts_as_commentable
  end
end
