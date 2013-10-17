class OptionallyCreateUserFromAuthHash
  include Interactor

  def perform
    unless context[:user]
      user = User.new(name: context[:info][:name])

      user.authentications.build({ provider: context[:provider],
                                 uid: context[:uid] })
      if user.save
        context[:user] = user
      else
        fail!
      end
    end
  end
end
