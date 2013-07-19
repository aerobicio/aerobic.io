require 'spec_helper'

describe Workout do
  it { should have_one(:fit_file) }

  it { should validate_presence_of(:active_duration) }
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:start_time) }
end
