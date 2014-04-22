require 'models/user'

# Authentication is an ActiveRecord model that represents
# a method via which a user can authenticate with the
# system.
#
class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :provider, :uid, presence: true

  validates :uid, uniqueness: { scope: :provider }
end
