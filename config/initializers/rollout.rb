require_relative "redis.rb"

STAFF_EMAILS = ["gareth.townsend@me.com", "desk@pixelbloom.com"]
PRIVATE_BETA_EMAILS = [
  "neikinu@gmail.com",
]

$rollout = Rollout.new($redis)

$rollout.define_group(:staff) do |user|
  STAFF_EMAILS.concat(PRIVATE_BETA_EMAILS).include?(user.email)
end
