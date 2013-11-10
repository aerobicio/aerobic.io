require_relative "../../app/helpers/following_helper"
require_relative "../../app/domain/member"

include FollowingHelper

describe FollowingHelper do
  describe "#following_link_for_members" do
    subject { following_link_for_members(member, other_member) }
    let(:member) { double(Domain::Member, id: 1) }
    let(:other_member) { double(Domain::Member, id: 2) }

    context "when following is inactive" do
      before do
        $switch_board.stub(:following_active?) { false }
      end

      it { should be_nil }
    end

    context "when following is active" do
      before do
        $switch_board.stub(:following_active?) { true }
      end

      describe "when both members are the same member" do
        let(:other_member) { member }

        it { should be_nil }
      end

      describe "when the member already follows the other member" do
        before do
          member.stub(:follows?).with(other_member) { true }
        end

        it { should == "<a href=\"/members/2/unfollow\">Unfollow</a>" }
      end

      describe "when the member does not follow the other member" do
        before do
          member.stub(:follows?).with(other_member) { false }
        end

        it { should == "<a href=\"/members/2/follow\">Follow</a>" }
      end
    end
  end
end
