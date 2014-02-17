require 'active_support/core_ext/object/try'

module Identities
  # View Controller for managing the logic around rendering /identities/new
  #
  class New
    def initialize(controller, identitiy)
      @controller = controller
      @identity = identitiy
    end

    def cache_key
      [name, email, full_messages].map(&:to_s).join(':')
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

    def render_errors
      if errors?
        @controller.render(partial: 'identities/form_errors',
                           locals: { view: self }).first
      end
    end
  end
end
