require_relative "redis.rb"

$rollout = Rollout.new($redis)
