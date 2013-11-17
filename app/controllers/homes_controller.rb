# HomesController is the logged out homepage for the application
#
# Currently all it does is provide an email registration for and a link to
# sign in form pre-registered users
#
class HomesController < ApplicationController
  skip_before_filter :login_required
  before_filter :redirect_members_to_dashboard

  private

  def redirect_members_to_dashboard
    redirect_to dashboard_path and return if current_user
  end
end
