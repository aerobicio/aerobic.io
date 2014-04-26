require 'load_paths_helper'
require 'activity/unfollowed_user_view'

describe Activity::UnfollowedUserView do
  let(:view) do
    described_class.new(context, current_member, unfollowed_member)
  end
  let(:current_member) do
    double(:current_member, id: 1,
                            name: 'Justin',
                            cache_key: 'foo')
  end
  let(:unfollowed_member) do
    double(:unfollowed_member, id: 2,
                               name: 'Gus',
                               cache_key: 'bar')
  end

  let(:context) { double }

  describe 'cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be contain the added workout and activity workout cache keys' do
      cache_key.should == 'foo:bar'
    end
  end
end
