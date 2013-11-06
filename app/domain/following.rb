require_relative "shared/initialize_from_data_object"

module Domain

  # Followings are a domain object to represent the current state of a user
  # following another user.
  #
  class Following
    include Domain::Shared::InitializeFromDataObject

    attr_reader :id
    attr_reader :user_id
    attr_reader :following_id
    attr_accessor :updated_at

    def persist
      user.followings << User.find(following_id)
      user.save

      set_id_from_last_following

      persist_to_activity_feeds
    end

    def user
      @user ||= User.find(@user_id)
    end

    private

    def set_id_from_last_following
      @id = @user.followings.last.id
    end

    def persist_to_activity_feeds
      Activity::FollowedUser.create(user_id: @user_id,
                                    activity_user_id: @user_id,
                                    activity_followed_user_id: @following_id)

      Activity::FollowedUser.create(user_id: @following_id,
                                    activity_user_id: @user_id,
                                    activity_followed_user_id: @following_id)


      user.followers.each do |user|
        Activity::FollowedUser.create(user_id: user.id,
                                      activity_user_id: @user_id,
                                      activity_followed_user_id: @following_id)
      end
    end
  end
end
