module Members
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    include Rails.application.routes.url_helpers

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
        'You have no workouts!'
      end
    end

    def member_title
      if @current_member == @member
        'You'
      else
        @member.name
      end
    end

    def workouts_path
      member_workouts_path(@member.id)
    end

    def followers_path
      member_followers_path(@member.id)
    end

    def follows_path
      member_follows_path(@member.id)
    end

    def workouts_count
      workouts.count
    end

    def follower_count
      followers.count
    end

    def follows_count
      follows.count
    end

    def member_created_date
      @member.created_at
    end

    private

    def followers
      @followers ||= @member.followers
    end

    def follows
      @follows ||= @member.followings
    end

    def workouts
      @workouts ||= @member.workouts
    end
  end
end
