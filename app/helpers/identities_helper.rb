require "active_support/core_ext/object/try"

# IdentitiesHelper contains the view classes used in each view located in
# identities/view.
#
module IdentitiesHelper

  # NewIdentityView is the view class used in views/identities/new
  #
  class NewIdentityView
    def initialize(identity)
      @identity = identity
    end

    def email
      @identity.try(:email)
    end

    def errors?
      @identity.try(:errors).try(:any?)
    end

    def error_count
      @identity.try(:errors).try(:count) || 0
    end

    def full_messages
      @identity.try(:errors).try(:full_messages) || []
    end

    def name
      @identity.try(:name)
    end
  end
end
