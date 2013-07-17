# OmniAuthUser extracts information from OmniAuth
# and creates a real User.
#
class OmniAuthUser
  def self.user_from_auth_hash(auth_hash)
    user = Authentication.find_by_provider_and_uid(auth_hash[:provider],
                                                   auth_hash[:uid]).try(:user)
    user ||= create_user_from_auth_hash(auth_hash)
    user
  end

  private

  def self.create_user_from_auth_hash(auth_hash)
    user = User.new(name: auth_hash[:info][:name])

    user.authentications.build({ provider: auth_hash[:provider],
                                 uid: auth_hash[:uid] })

    user.save!
    user
  end
end
