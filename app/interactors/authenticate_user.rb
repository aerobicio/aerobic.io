class AuthenticateUser
  include Interactor::Organizer

  organize FindUserFromOmniAuthHash, OptionallyCreateUserFromAuthHash
end
