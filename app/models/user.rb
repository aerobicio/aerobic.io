# User is an ActiveRecord model that represents
# a user in our system.
#
class User < ActiveRecord::Base
  has_many :authentications

  validates :name, presence: true
end
