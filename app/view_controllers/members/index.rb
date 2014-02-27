module Members
  # View Controller for managing the logic around rendering /members/index
  #
  class Index
    def initialize(controller, member)
      @controller = controller
      @member = member
    end

    def cache_key
      [@member.cache_key, other_members.map(&:cache_key)].flatten.join(':')
    end

    def render_other_members
      @controller.render(other_members).first
    end

    private

    def other_members
      @other_members ||= User.where.not(id: @member.id)
    end
  end
end
