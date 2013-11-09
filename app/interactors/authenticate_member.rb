require "interactor"
require "active_support/core_ext/object/try"

# AuthenticateMember uses information provided by OmniAuth to authenticate
# a User, or create a new User and Authentication object, then add the user_id
# to the context.
#
class AuthenticateMember
  include Interactor

  def perform
    find_existing_user_from_context || create_user_from_context

    if @user
      context[:user_id] = @user.id
    else
      context.fail!
    end
  end

  private

  def find_existing_user_from_context
    @user = Authentication.find_by_provider_and_uid(provider, uid).try(:user)
  end

  def create_user_from_context
    @user = User.new(name: info[:name])

    @user.authentications.build({ provider: provider,
                                  uid: uid })

    @user = nil unless @user.save
  end
end
