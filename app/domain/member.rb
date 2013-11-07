require_relative "shared/initialize_from_data_object"
require_relative "following"

module Domain

  # A member of aerobic.io
  class Member
    include Domain::Shared::InitializeFromDataObject

    attr_reader :id
    attr_accessor :name

    def self.find(id)
      self.new(User.find(id))
    end

    def self.all
      User.all.map { |user| self.new(user) }
    end

    def cache_key
      user.cache_key
    end

    def user
      @user ||= User.find(@id)
    end

    def follow(member)
      following = Domain::Following.new(user_id: id, following_id: member.id)
      following.persist
    end

    def unfollow(member)
      Activity::UnfollowedUser.create(user_id: @id,
                                      activity_user_id: @id,
                                      activity_followed_user_id: member.id)

      sql = <<-SQL
        delete from users_followings
        where user_id = #{@id}
        and following_id = #{member.id}
      SQL

      ActiveRecord::Base.connection.execute(sql)
    end

    def follows?(member)
      User.find(@id).followings.map(&:id).include?(member.id)
    end
  end
end
