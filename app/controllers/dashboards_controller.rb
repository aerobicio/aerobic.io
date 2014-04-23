# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @view = Dashboards::Show.new(self, current_user, params[:page])
  end
end
