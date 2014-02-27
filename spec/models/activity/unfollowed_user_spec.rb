require 'active_record_helper'
require_relative '../../support/shared/activity'
require_relative '../../../app/models/activity/unfollowed_user'

describe Activity::UnfollowedUser do
  it_should_behave_like 'an activity model'
  it_should_behave_like 'an activity models public API'
end
