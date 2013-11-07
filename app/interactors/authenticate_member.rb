require "interactor"
require "active_support/core_ext/object/try"

# AuthenticateMember uses information provided by OmniAuth to authenticate
# a User, or create a new User and Authentication object, then add the user_id
# to the context.
#
class AuthenticateMember
  include Interactor

  def perform
    user = Authentication.find_by_provider_and_uid(context[:provider],
                                                   context[:uid]).try(:user)
    user ||= create_user_from_context
    context[:user_id] = user.id
  end

  private

  def create_user_from_context
    user = User.new(name: context[:info][:name])

    user.authentications.build({ provider: context[:provider],
                                 uid: context[:uid] })

    user.save!
    user
  end
end
