require_relative "../domain/activity_feed"

# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @workouts = Domain::ActivityFeed.workouts(current_user.id)
  end
end
