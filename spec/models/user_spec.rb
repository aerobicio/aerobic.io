require 'load_paths_helper'
require 'active_record_helper'
require 'user'

describe User do
  let(:user) { described_class.new }

  it { should have_many(:activities) }
  it { should have_many(:authentications) }
  it { should have_many(:workouts) }

  it { should have_and_belong_to_many(:followings) }
  it { should have_and_belong_to_many(:followers) }

  it { should validate_presence_of(:name) }

  describe '#to_partial_path' do
    subject(:to_partial_path) { user.to_partial_path }

    it { should == 'members/member' }
  end

  describe '#email' do
    subject(:email) { user.email }

    let(:uid) { 1 }
    let(:identity) { double(:identity, email: 'test@example.com') }

    before do
      stub_const('Identity', Class.new)
      user.stub(:authentications) { [double(:authentication, uid: uid)] }
      Identity.should_receive(:find).with(uid) { identity }
    end

    it { should == identity.email }
  end

  describe '#follows?' do
    subject(:follows?) { user.follows?(other_user) }

    let(:other_user) { double(:other_user, id: other_user_id) }
    let(:other_user_id) { 1 }

    before do
      user.stub(:followings) { following_ids }
    end

    context 'when following other user' do
      let(:following_ids) { [double(id: other_user_id), double(id: 2)] }

      it { should be_true }
    end

    context 'when not following other user' do
      let(:following_ids) { [double(id: 2), double(id: 3)] }

      it { should be_false }
    end
  end

  describe '#name_in_context_of(member)' do
    subject { user.name_in_context_of(member) }

    context 'when member is the user' do
      let(:member) { user }

      it { should == I18n.t('you') }
    end

    context 'when member is not the user' do
      let(:member) { User.new }

      it { should == user.name }
    end
  end
end
