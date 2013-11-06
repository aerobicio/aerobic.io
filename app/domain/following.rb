require_relative "shared/initialize_from_data_object"

module Domain
  class Following
    include Domain::Shared::InitializeFromDataObject

    attr_reader :id
    attr_reader :user_id
    attr_reader :following_id
    attr_accessor :updated_at

    def persist
      user = User.find(user_id)
      user.followings << User.find(following_id)
      user.save

      following = user.followings.last
      @id = following.id

      persist_to_redis(following.created_at.to_i)
    end

    def following
      @following ||= User.find(@following_id)
    end

    def user
      @user ||= User.find(@user_id)
    end

    def cache_key
      "domain:following:#{id}:#{updated_at}"
    end

    def to_partial_path
      "followings/following"
    end

    private

    def persist_to_redis(score)
      # $redis.set(redis_key, to_json)
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

    def to_json
      %!{"type":"following",
         "id":#{@id},
         "user_id":#{@user_id},
         "following_id":#{@following_id},
         "updated_at":#{@updated_at.to_i}
        }!
    end

    def redis_key
      "user:#{@user_id}:following:#{@id}"
    end
  end
end
