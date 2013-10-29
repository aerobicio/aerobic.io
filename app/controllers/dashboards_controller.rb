require_relative "../domain/activity_feed"

# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @activities = Domain::ActivityFeed.activities(current_user.id)
  end
end
