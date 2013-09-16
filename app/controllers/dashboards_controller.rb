# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @workouts = current_user.workouts.all
  end
end
