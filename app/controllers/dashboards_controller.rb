# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @activities = current_user.activities
  end
end
