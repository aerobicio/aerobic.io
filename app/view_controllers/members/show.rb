require 'i18n'

module Members
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    attr_reader :member

    def initialize(controller, current_member, member_id)
      @controller = controller
      @current_member = current_member
      @member = User.find(member_id)
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
                           object: workouts.group_by(&:date)
                          ).first
      else
        if @current_member == member
          I18n.t('workouts.none.first_person')
        else
          I18n.t('workouts.none.third_person', name: member.name)
        end
      end
    end

    private

    def workouts
      @workouts ||= @member.workouts
    end
  end
end
