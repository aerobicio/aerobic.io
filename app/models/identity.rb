class Identity < OmniAuth::Identity::Models::ActiveRecord
  WHITE_LIST = %w(gareth.townsend@me.com justin@pixelbloom.com)

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  # Beta users only
  validates :email, inclusion: { in: WHITE_LIST }
end
