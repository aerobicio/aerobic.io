require 'spec_helper'

describe FollowMember do
  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
    }
  end

  subject(:result) { described_class.perform(context) }

  let(:member) do
    double(:member, followings: followings,
                    followers: followers,
          )
  end

  let(:followings) { double(:followings, include?: false).as_null_object }
  let(:followers) { double(:followers).as_null_object }

  let(:followed_member) { double(:followed_member, name: 'Gus', touch: true) }

  let(:activity) { double(:activity, save: activity_persisted) }

  before do
    User.should_receive(:find).with(context[:member_id]) { member }
    User.should_receive(:find).with(context[:followed_id]) { followed_member }
  end

  context 'when CreateFollowing is successful' do
    before do
      followings.should_receive(:<<).with(followed_member)
    end

    context 'and when AddFollowingToActivityFeeds is successful' do
      let(:activity_persisted) { true }

      before do
        Activity::FollowedUser.stub(:create) { activity }
      end

      it 'should be marked as successful' do
        result.success?.should be_true
      end

      it 'should add the member to the context' do
        result.member.should == member
      end

      it 'should add the followed member to the context' do
        result.followed_member.should == followed_member
      end

      it 'should add the successful notice to the context' do
        result.notice.should == 'Now following Gus'
      end
    end

    context 'when when AddFollowingToActivityFeeds is unsuccessful' do
      let(:activity_persisted) { false }

      before do
        Activity::FollowedUser.stub(:create) { activity }
      end

      it 'should not be marked as successful' do
        result.success?.should be_false
      end

      it 'should add the member to the context' do
        result.member.should == member
      end

      it 'should add the followed member to the context' do
        result.followed_member.should == followed_member
      end

      it 'should add the successful notice to the context' do
        result.notice.should == 'Could not follow Gus'
      end
    end
  end

  context 'when CreateFollowing is unsuccessful' do
    before do
      followings.should_receive(:<<).with(followed_member) do
        fail ActiveRecord::ActiveRecordError.new('lol')
      end

      Activity::FollowedUser.should_not_receive(:create)
    end

    it 'should not be marked as successful' do
      result.success?.should be_false
    end

    it 'should add the member to the context' do
      result.member.should == member
    end

    it 'should add the followed member to the context' do
      result.followed_member.should == followed_member
    end

    it 'should add the unsuccessful notice to the context' do
      result.notice.should == 'Could not follow Gus'
    end
  end
end
