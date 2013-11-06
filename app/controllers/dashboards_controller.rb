# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @activities = Activity.all.where(user_id: current_user.id)
  end
end
