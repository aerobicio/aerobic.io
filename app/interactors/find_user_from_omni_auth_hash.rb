class FindUserFromOmniAuthHash
  include Interactor

  def perform
    authentication = Authentication.find_by_provider_and_uid(context[:provider],
                                                             context[:uid])

    if authentication
      context[:user] = authentication.user
    end
  end
end
