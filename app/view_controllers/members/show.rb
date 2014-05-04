require 'i18n'
require 'kaminari'

module Members
  # View Controller for managing the logic around rendering /members/show
  #
  class Show
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
        member.followers.count,
        member.followings.count,
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
      member.created_at.to_date.to_s(:long)
    end

    def member_following
      I18n.t('members.show.card.following_members',
             count: member.followings.count)
    end

    def member_followers
      I18n.t('members.show.card.followed_by_members',
             count: member.followers.count)
    end

    private

    def viewing_self?
      @current_member == member
    end

    def workouts
      @workouts ||= member.workouts.desc.page(@page)
    end
  end
end
