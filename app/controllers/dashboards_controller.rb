require_relative "../domain/workout"

# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @workouts = Domain::Workout.all_for(current_user.id)
  end
end
