require "active_record_helper"
require_relative "../../../app/models/activity/added_workout"
require_relative "../../support/shared/activity_spec"

describe Activity::AddedWorkout do
  it_should_behave_like "an activity model"
  it_should_behave_like "an activity models public API"
end
