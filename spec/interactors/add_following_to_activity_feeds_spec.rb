require_relative ".././../app/interactors/add_following_to_activity_feeds"
require "active_support/core_ext/object/try"

describe AddFollowingToActivityFeeds do
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
  let(:followed_member) { double(:followed_member, name: "Gus") }
  let(:followers) { [double(:follower, id: 3)] }

  before do
    stub_const("Activity::FollowedUser", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    context "when successfull" do
      before do
        Activity::FollowedUser.should_receive(:create).with(member_feed)
        Activity::FollowedUser.should_receive(:create).with(followed_member_feed)
        Activity::FollowedUser.should_receive(:create).with(follower_member_feed)

        Activity::FollowedUser.stub(:create) { true }
      end

      it "should be marked as successfull" do
        result.success?.should be_true
      end
    end

    context "when unsuccessfull" do
      before do
        Activity::FollowedUser.stub(:create) { false }
      end

      it "should not be marked as successfull" do
        result.success?.should be_false
      end
    end
  end
end
