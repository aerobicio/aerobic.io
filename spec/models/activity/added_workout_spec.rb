require 'load_paths_helper'
require 'active_record_helper'
require 'support/shared/activity'
require 'activity/added_workout'

describe Activity::AddedWorkout do
  before do
    Time.zone = 'Melbourne'
  end

  it_should_behave_like 'an activity model'
  it_should_behave_like 'an activity models public API'
end
