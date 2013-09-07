require_relative "../domain/member"

# ApplicationController is the root controller of the application.
#
# Methods available here are available in all controllers.
class ApplicationController < ActionController::Base
  before_filter :login_required

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= Domain::Member.find(session[:user_id])
    end
  end

  def login_required
    redirect_to(sign_in_path) unless current_user
  end
end
