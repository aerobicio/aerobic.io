require_relative ".././../app/interactors/add_following_to_activity_feeds"
require "active_support/core_ext/object/try"

describe AddFollowingToActivityFeeds do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
      member: member,
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
  let(:followers) { [double(:follower, id: 3)] }

  before do
    stub_const("Activity::FollowedUser", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    before do
      Activity::FollowedUser.should_receive(:create).with(member_feed)
      Activity::FollowedUser.should_receive(:create).with(followed_member_feed)
      Activity::FollowedUser.should_receive(:create).with(follower_member_feed)
    end

    context "when successfull" do
      it "should be marked as successfull" do
        result.success?.should be_true
      end
    end

    context "when unsuccessfull" do
      pending("Implementation of rollback strategy")
    end
  end
end
