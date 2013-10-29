require_relative "authentication"
require_relative "workout"

# User is an ActiveRecord model that represents
# a user in our system.
#
class User < ActiveRecord::Base
  has_many :authentications
  has_many :workouts

  has_and_belongs_to_many :followings,
                          association_foreign_key: 'following_id',
                          class_name: 'User',
                          join_table: 'users_followings'


  has_and_belongs_to_many :followers,
                          foreign_key: 'following_id',
                          association_foreign_key: 'user_id',
                          class_name: 'User',
                          join_table: 'users_followings'

  validates :name, presence: true
end
