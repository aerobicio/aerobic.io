# IdentitiesController is used to manage Omniauth Identity Provider objects.
#
# Right now we use it solely to display the Sign Up form.
#
class IdentitiesController < ApplicationController
  skip_before_filter :login_required, if: ->{ $rollout.active?(:sign_up) }

  def new
    @identity = env["omniauth.identity"]
  end
end
