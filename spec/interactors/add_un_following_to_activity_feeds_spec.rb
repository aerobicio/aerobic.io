require_relative "../../app/interactors/add_un_following_to_activity_feeds"

describe AddUnFollowingToActivityFeeds do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
      unfollowed_member: unfollowed_member,
    }
  end

  let(:member_feed) do
    {
      user_id: context[:member_id],
      activity_user_id: context[:member_id],
      activity_followed_user_id: context[:followed_id],
    }
  end

  let(:member) { double(:member) }
  let(:unfollowed_member) { double(:unfollowed_member, name: "Gus") }

  before do
    stub_const("Activity::UnfollowedUser", Class.new)
    stub_const("User", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    before do
      Activity::UnfollowedUser.should_receive(:create).with(member_feed) do
        success
      end
    end

    context "when successfull" do
      let(:success) { true }

      it "should be marked as successfull" do
        result.success?.should be_true
      end
    end

    context "when unsuccessfull" do
      let(:success) { false }

      it "should not be marked as successfull" do
        result.success?.should be_false
      end

      it "should add the unsuccessful notice to the context" do
        result.notice.should == "Could not unfollow Gus"
      end
    end
  end
end
