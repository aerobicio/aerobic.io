require_relative "../../app/interactors/delete_following"

describe DeleteFollowing do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
    }
  end

  let(:member) { double(:member, follows?: follows) }
  let(:unfollowed_member) { double(:unfollowed_member, name: "Gus") }

  let(:connection) { double(:connection) }
  let(:sql) do
    <<-SQL
      delete from users_followings
      where user_id = #{context[:member_id]}
      and following_id = #{context[:followed_id]}
    SQL
  end

  before do
    stub_const("ActiveRecord::Base", Class.new)
    stub_const("User", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    context "when successful" do
      before do
        User.should_receive(:find).with(context[:member_id]) { member }
        User.should_receive(:find).
          with(context[:followed_id]) { unfollowed_member }
      end

      context "when member follows other followed_member" do
        let(:follows) { true }

        before do
          ActiveRecord::Base.should_receive(:connection) { connection }
          connection.should_receive(:execute).with(sql)
        end

        it "should be marked as successfull" do
          result.success?.should be_true
        end

        it "should add the notice to the context" do
          name = unfollowed_member.name
          result.notice.should == "No longer following #{name}"
        end
      end

      context "when member does not follow other followed_member" do
        let(:follows) { false }

        before do
          ActiveRecord::Base.should_not_receive(:connection) { connection }
          connection.should_not_receive(:execute)
        end

        it "should not be marked as successfull" do
          result.success?.should be_false
        end

        it "should add the notice to the context" do
          result.notice.should == "Could not unfollow #{unfollowed_member.name}"
        end
      end
    end
  end
end
