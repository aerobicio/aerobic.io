require_relative "redis.rb"

STAFF_EMAILS = ["gareth.townsend@me.com", "desk@pixelbloom.com"]

$rollout = Rollout.new($redis)

$rollout.define_group(:staff) do |user|
  STAFF_EMAILS.include?(user.email)
end
