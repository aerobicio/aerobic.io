require 'spec_helper'

describe User do
  it { should have_many(:authentications) }
  it { should have_many(:workouts) }

  it { should validate_presence_of(:name) }
end
