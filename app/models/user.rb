require_relative "authentication"
require_relative "workout"

# User is an ActiveRecord model that represents
# a user in our system.
#
class User < ActiveRecord::Base
  has_many :authentications
  has_many :workouts

  validates :name, presence: true
end
