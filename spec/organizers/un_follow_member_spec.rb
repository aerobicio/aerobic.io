require "spec_helper"

describe UnFollowMember do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
    }
  end

  subject(:result) { described_class.perform(context) }

  let(:member) { double(:member, follows?: follows) }
  let(:followed_member) { double(:followed_member, name: "Gus") }

  before do
    User.should_receive(:find).with(context[:member_id]) { member }
    User.should_receive(:find).with(context[:followed_id]) { followed_member }
  end

  context "when DeleteFollowing is successful" do
    let(:follows) { true }

    before do
      ActiveRecord::Base.connection.stub(:execute)
    end

    context "and when AddUnFollowingToActivityFeeds is successful" do
      before do
        Activity::UnfollowedUser.stub(:create) { true }
      end

      it "should be marked as successful" do
        result.success?.should be_true
      end

      it "should add the member to the context" do
        result.member.should == member
      end

      it "should add the unfollowed member to the context" do
        result.unfollowed_member.should == followed_member
      end

      it "should add the successful notice to the context" do
        result.notice.should == "No longer following Gus"
      end
    end

    context "when when AddUnFollowingToActivityFeeds is unsuccessful" do
      before do
        Activity::UnfollowedUser.stub(:create) { false }
      end

      it "should not be marked as successful" do
        result.success?.should be_false
      end

      it "should add the member to the context" do
        result.member.should == member
      end

      it "should add the followed member to the context" do
        result.unfollowed_member.should == followed_member
      end

      it "should add the successful notice to the context" do
        result.notice.should == "Could not unfollow Gus"
      end
    end
  end

  context "when DeleteFollowing is unsuccessful" do
    let(:follows) { false }
    before do
      ActiveRecord::Base.connection.should_not_receive(:execute)
      Activity::UnfollowedUser.should_not_receive(:create)
    end

    it "should not be marked as successful" do
      result.success?.should be_false
    end

    it "should add the member to the context" do
      result.member.should == member
    end

    it "should add the unfollowed member to the context" do
      result.unfollowed_member.should == followed_member
    end

    it "should add the unsuccessful notice to the context" do
      result.notice.should == "Could not unfollow Gus"
    end
  end
end
