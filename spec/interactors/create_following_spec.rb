require_relative ".././../app/interactors/create_following"
require "active_support/core_ext/object/try"

describe CreateFollowing do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
    }
  end

  let(:member) { double(:member, followings: followings) }
  let(:followed_member) { double(:followed_member) }

  let(:followings) { double(:followings) }

  before do
    stub_const("User", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    before do
      User.should_receive(:find).with(context[:member_id]) { member }
      User.should_receive(:find).with(context[:followed_id]) { followed_member }
      followings.should_receive(:<<).with(followed_member)
      member.should_receive(:save) { success }
    end

    context "when successfull" do
      let(:success) { true }

      it "should be marked as successfull" do
        result.success?.should be_true
      end

      it "should add the member to the context" do
        result.member.should == member
      end

      it "should add the followed member to the context" do
        result.followed_member.should == followed_member
      end
    end

    context "when unsuccessfull" do
      let(:success) { false }

      it "should be marked as unsuccessfull" do
        result.success?.should be_false
      end

      it "should add the member to the context" do
        result.member.should == member
      end

      it "should not add the followed member to the context" do
        result.try(:followed_member).should == nil
      end
    end
  end
end
