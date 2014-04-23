require 'redis'

STAFF_EMAILS = ["gareth.townsend@me.com", "desk@pixelbloom.com"]
PRIVATE_BETA_EMAILS = [
  "neikinu@gmail.com",
]

$rollout = Rollout.new($redis)

$rollout.define_group(:staff) do |user|
  STAFF_EMAILS.include?(user.email)
end

$rollout.define_group(:testers) do |user|
  PRIVATE_BETA_EMAILS.include?(user.email)
end
