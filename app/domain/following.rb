require_relative "shared/initialize_from_data_object"
require_relative "activity_feed"

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
      $redis.set(redis_key, to_json)
      Domain::ActivityFeed.add_activity(@user_id, score, redis_key)
      Domain::ActivityFeed.add_activity(@following_id, score, redis_key)

      user.followers.each do |user|
        Domain::ActivityFeed.add_activity(user.id, score, redis_key)
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
