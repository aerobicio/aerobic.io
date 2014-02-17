require 'omniauth'
require 'omniauth-identity'
require 'valid_email'

class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
end
