require "active_record_helper"
require_relative "../../app/models/user"

describe User do
  it { should have_many(:authentications) }
  it { should have_many(:workouts) }

  it { should have_and_belong_to_many(:followings) }
  it { should have_and_belong_to_many(:followers) }

  it { should validate_presence_of(:name) }
end
