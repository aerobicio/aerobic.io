require "active_support/core_ext/object/try"

module Domain

  # A member of aerobic.io
  class Member
    attr_reader :id
    attr_accessor :name

    def initialize(data_object)
      @id = data_object.try(:id)
      @name = data_object.try(:name)
    end

    def self.find(id)
      self.new(User.find(id))
    end
  end
end
