require_relative '.././../app/interactors/create_following'
require 'active_record/errors'
require 'active_support/core_ext/object/try'

describe CreateFollowing do
  subject(:result) { described_class.perform(context) }

  let(:context) do
    {
      member_id: 1,
      followed_id: 2,
    }
  end

  let(:member) { double(:member, followings: followings, name: 'GT') }
  let(:followed_member) { double(:followed_member, name: 'Gus') }

  let(:followings) { double(:followings, include?: already_following) }

  before do
    stub_const('User', Class.new)
    User.stub(:find).with(context[:member_id]) { member }
    User.stub(:find).with(context[:followed_id]) { followed_member }
  end

  context 'when trying to follow a member' do
    let(:already_following) { false }

    context 'and following is persisted' do
      before do
        followings.should_receive(:<<).with(followed_member)
      end

      context 'and followed mebers updated_at is modified' do
        before do
          followed_member.should_receive(:touch) { true }
        end

        it 'should be marked as successfull' do
          result.success?.should be_true
        end

        it 'should add the member to the context' do
          result.member.should == member
        end

        it 'should add the notice to the context' do
          result.notice.should == "Now following #{followed_member.name}"
        end
      end

      context 'and followed mebers updated_at is not modified' do
        before do
          followed_member.should_receive(:touch) { false }
        end

        it 'should be marked as unsuccessfull' do
          result.success?.should be_false
        end

        it 'should add the member to the context' do
          result.member.should == member
        end

        it 'should add the followed_member to the context' do
          result.followed_member.should == followed_member
        end

        it 'should add the notice to the context' do
          result.notice.should == "Could not follow #{followed_member.name}"
        end
      end
    end

    context 'and following is not persisted' do
      before do
        followings.should_receive(:<<).with(followed_member) do
          fail ActiveRecord::ActiveRecordError.new('lol')
        end
      end

      it 'should be marked as unsuccessfull' do
        result.success?.should be_false
      end

      it 'should add the member to the context' do
        result.member.should == member
      end

      it 'should add the followed_member to the context' do
        result.followed_member.should == followed_member
      end

      it 'should add the notice to the context' do
        result.notice.should == "Could not follow #{followed_member.name}"
      end
    end
  end

  context 'when trying to follow yourself' do
    let(:context) do
      {
        member_id: 1,
        followed_id: 1,
      }
    end

    let(:already_following) { false }

    before do
      User.should_receive(:find).with(context[:member_id]).twice { member }
    end

    it 'should be marked as unsuccessfull' do
      result.success?.should be_false
    end

    it 'should add the member to the context' do
      result.member.should == member
    end

    it 'should add the followed_member to the context' do
      result.followed_member.should == member
    end

    it 'should add the notice to the context' do
      result.notice.should == "Could not follow #{member.name}"
    end
  end

  context 'when trying to follow a member you already follow' do
    let(:already_following) { true }

    it 'should be marked as unsuccessfull' do
      result.success?.should be_false
    end

    it 'should add the member to the context' do
      result.member.should == member
    end

    it 'should add the followed_member to the context' do
      result.followed_member.should == followed_member
    end

    it 'should add the notice to the context' do
      result.notice.should == "Could not follow #{followed_member.name}"
    end
  end
end
