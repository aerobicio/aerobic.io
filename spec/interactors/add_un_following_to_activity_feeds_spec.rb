require_relative "../../app/interactors/add_un_following_to_activity_feeds"

describe AddUnFollowingToActivityFeeds do
  let(:context) do
    {
      member_id: 1,
      unfollowed_id: 2,
    }
  end

  let(:member_feed) do
    {
      user_id: context[:member_id],
      activity_user_id: context[:member_id],
      activity_followed_user_id: context[:unfollowed_id],
    }
  end

  let(:member) { double(:member) }

  before do
    stub_const("Activity::UnfollowedUser", Class.new)
    stub_const("User", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    before do
      Activity::UnfollowedUser.should_receive(:create).with(member_feed)
      User.should_receive(:find).with(context[:member_id]) { member }
    end

    context "when successfull" do
      it "should be marked as successfull" do
        result.success?.should be_true
      end

      it "should add the member to the context" do
        result.member.should == member
      end
    end

    context "when unsuccessfull" do
      pending("Implementation of rollback strategy")
    end
  end
end
