require 'active_record_helper'
require_relative '../../support/shared/activity'
require_relative '../../../app/models/activity/added_workout'

describe Activity::AddedWorkout do
  it_should_behave_like 'an activity model'
  it_should_behave_like 'an activity models public API'
end
