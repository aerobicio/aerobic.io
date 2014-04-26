# IdentitiesController is used to manage Omniauth Identity Provider objects.
#
# Right now we use it solely to display the Sign Up form.
#
class IdentitiesController < ApplicationController
  skip_before_action :login_required, if: -> { $switch_board.sign_up_active? }
  skip_before_action :login_required, if: -> { beta_token_matches? }

  layout 'unauthenticated'

  def new
    @view = Identities::New.new(self, env['omniauth.identity'])
    render layout: 'authentication'
  end

  private

  def beta_token_matches?
    !ENV['BETA_TOKEN'].blank? && params[:token] == ENV['BETA_TOKEN']
  end
end
