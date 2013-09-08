require_relative "../domain/workout"

# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @workouts = $redis.zrevrange("user:#{current_user.id}:activity", 0, -1)
    @workouts = @workouts.map do |workout|
      Domain::Workout.new($redis.get(workout))
    end
  end
end
