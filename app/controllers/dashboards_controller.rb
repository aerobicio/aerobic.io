# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @workouts = Workout.all
  end
end
