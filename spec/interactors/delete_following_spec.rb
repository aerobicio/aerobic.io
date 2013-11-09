require_relative "../../app/interactors/delete_following"

describe DeleteFollowing do
  let(:context) do
    {
      member_id: 1,
      unfollowed_id: 2,
    }
  end

  let(:unfollowed_member) { double(:unfollowed_member, name: "Gus") }

  let(:connection) { double(:connection) }
  let(:sql) do
    <<-SQL
      delete from users_followings
      where user_id = #{context[:member_id]}
      and following_id = #{context[:unfollowed_id]}
    SQL
  end

  before do
    stub_const("ActiveRecord::Base", Class.new)
    stub_const("User", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    before do
      User.should_receive(:find).
        with(context[:unfollowed_id]) { unfollowed_member }

      ActiveRecord::Base.should_receive(:connection) { connection }
      connection.should_receive(:execute).with(sql)
    end

    context "when successfull" do
      it "should be marked as successfull" do
        result.success?.should be_true
      end

      it "should add the notice to the context" do
        result.notice.should == "No longer following #{unfollowed_member.name}"
      end
    end
  end
end
