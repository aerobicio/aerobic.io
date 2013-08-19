# SessionsController manages the user's session (sign_in and sign_out).
#
# When signing in we use the OmniAuthUser object to find or create a user
# from the given auth_hash, at this point the user has already signed in
# using one of OmniAuth's providers.
#
class SessionsController < ApplicationController
  skip_before_filter :login_required

  def new
  end

  def create
    reset_session

    user = OmniAuthUser.user_from_auth_hash(auth_hash)
    session[:user_id] = user.id

    redirect_to dashboard_path
  end

  def destroy
    reset_session
    redirect_to :root
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
