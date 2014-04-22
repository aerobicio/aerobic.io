require 'kaminari'

module Members
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    attr_reader :member

    def initialize(controller, current_member, member_id, page = 1)
      @controller = controller
      @current_member = current_member
      @member = User.find(member_id)
      @page = page
    end

    def cache_key
      [
        @current_member.cache_key,
        @member.cache_key,
        workouts.map(&:cache_key)
      ].flatten.join(':')
    end

    def render_workouts
      if workouts.any?
        @controller.render(partial: 'workouts/grouped',
                           object: workouts.group_by(&:date),
                           locals: { workouts: workouts }
                          ).first
      else
        'You have no workouts!'
      end
    end

    private

    def workouts
      @workouts ||= @member.workouts.desc.page(@page)
    end
  end
end
