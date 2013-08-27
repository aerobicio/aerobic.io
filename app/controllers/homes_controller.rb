# HomesController is the logged out homepage for the application
#
# Currently all it does is provide an email registration for and a link to
# sign in for pre-registered users
#
class HomesController < ApplicationController
  skip_before_filter :login_required

  layout false

  def new
  end
end
