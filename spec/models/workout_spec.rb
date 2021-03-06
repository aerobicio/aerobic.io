require 'load_paths_helper'
require 'active_record_helper'
require 'workout'

describe Workout do
  it { should belong_to(:user) }

  it { should validate_presence_of(:active_duration) }
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:user) }
end
