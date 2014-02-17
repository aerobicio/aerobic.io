require_relative '.././../app/interactors/add_following_to_activity_feeds'
require 'active_support/core_ext/object/try'

describe AddFollowingToActivityFeeds do
  subject(:result) { described_class.perform(context) }

  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
      member: member,
      followed_member: followed_member,
    }
  end

  let(:member_feed) do
    {
      user_id: context[:member_id],
      activity_user_id: context[:member_id],
      activity_followed_user_id: context[:followed_id],
    }
  end

  let(:followed_member_feed) do
    {
      user_id: context[:followed_id],
      activity_user_id: context[:member_id],
      activity_followed_user_id: context[:followed_id],
    }
  end

  let(:follower_member_feed) do
    {
      user_id: followers.first.id,
      activity_user_id: context[:member_id],
      activity_followed_user_id: context[:followed_id],
    }
  end

  let(:member) { double(:member, followers: followers) }
  let(:followed_member) { double(:followed_member, name: 'Gus') }
  let(:followers) { [double(:follower, id: 3)] }

  let(:activity) { double(:activity, save: activity_persisted) }

  before do
    stub_const('Activity::FollowedUser', Class.new)

    Activity::FollowedUser.should_receive(:create).with(member_feed) do
      activity
    end
  end

  context 'when all feeds are updated successfully' do
    let(:activity_persisted) { true }

    context 'and followers are not involved in the following event' do
      before do
        Activity::FollowedUser.should_receive(:create).
          with(followed_member_feed) { activity }

        Activity::FollowedUser.should_receive(:create).
          with(follower_member_feed) { activity }
      end

      it 'should be marked as successful' do
        result.success?.should be_true
      end
    end

    context 'and followers are involved in the following event' do
      let(:followers) { [double(:follower, id: 2)] }

      before do
        Activity::FollowedUser.should_receive(:create).
          with(followed_member_feed).once { activity }
      end

      it 'should be marked as successful' do
        result.success?.should be_true
      end
    end
  end

  context 'when feeds are not updated succesfully' do
    let(:activity_persisted) { false }

    it 'should not be marked as successful' do
      result.success?.should be_false
    end
  end
end
