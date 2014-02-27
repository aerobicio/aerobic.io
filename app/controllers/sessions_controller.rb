# SessionsController manages the user's session (sign_in and sign_out).
#
# When signing in we use the OmniAuthUser object to find or create a user
# from the given auth_hash, at this point the user has already signed in
# using one of OmniAuth's providers.
#
class SessionsController < ApplicationController
  skip_before_filter :login_required

  layout 'unauthenticated'

  def new
    render layout: 'authentication'
  end

  def create
    reset_session

    result = AuthenticateMember.perform(auth_hash)

    if result.success?
      session[:user_id] = result.user_id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to :root
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
