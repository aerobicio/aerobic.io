require_relative "shared/initialize_from_data_object"

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

    def follows?(member)
      user.followings.map(&:id).include?(member.id)
    end
  end
end
