require 'load_paths_helper'
require 'activity/followed_user_view'

describe Activity::FollowedUserView do
  let(:view) do
    described_class.new(context, current_member, followed_member)
  end
  let(:current_member) do
    double(:current_member, id: 1,
                            name: 'Justin',
                            cache_key: 'foo')
  end
  let(:followed_member) do
    double(:followed_member, id: 2,
                             name: 'Gus',
                             cache_key: 'bar')
  end

  let(:context) { double }

  describe 'cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be contain the current and followed member cache keys' do
      cache_key.should == 'foo:bar'
    end
  end
end
