require 'i18n'
require 'kaminari'

module Members
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
    include Rails.application.routes.url_helpers

    attr_reader :member

    def initialize(context, current_member, member_id, page = 1)
      @context = context
      @current_member = current_member
      @member = User.find(member_id)
      @page = page
    end

    def cache_key
      [
        @current_member.cache_key,
        member.cache_key,
        workouts.map(&:cache_key)
      ].flatten.join(':')
    end

    def render_workouts
      if workouts.any?
        @context.render(partial: 'workouts/grouped',
                        object: workouts.group_by(&:date),
                        locals: { workouts: workouts }
                       )
      else
        if viewing_self?
          I18n.t('workouts.none.first_person')
        else
          I18n.t('workouts.none.third_person', name: member.name)
        end
      end
    end

    def render_workout_pagination
      @context.paginate(workouts)
    end

    def member_title
      if viewing_self?
        I18n.t('members.show.card.title.first_person')
      else
        member.name
      end
    end

    def member_joined_date
      member.created_at
    end

    def workouts_count
      member.workouts.count
    end

    def follower_count
      followers.count
    end

    def following_count
      following.count
    end

    def workouts_path
      member_workouts_path(member.id)
    end

    def followers_path
      member_followers_path(member.id)
    end

    def followings_path
      member_follows_path(member.id)
    end

    private

    def viewing_self?
      @current_member == member
    end

    def followers
      @followers ||= member.followers
    end

    def following
      @following ||= member.followings
    end

    def workouts
      @workouts ||= member.workouts.desc.page(@page)
    end
  end
end
