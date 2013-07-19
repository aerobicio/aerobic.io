# DashboardsController is used to display the users Dashboard.
#
class DashboardsController < ApplicationController
  def show
    @fit_files = FitFile.all
  end
end
