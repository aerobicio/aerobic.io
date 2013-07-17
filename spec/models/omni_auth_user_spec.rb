require_relative '../../app/models/omni_auth_user'

describe OmniAuthUser do
  describe '#user_from_auth_hash' do
    subject { OmniAuthUser.user_from_auth_hash(auth_hash) }

    let(:authentication_const) { stub_const("Authentication", Class.new) }
    let(:user_const) { stub_const("User", Class.new) }

    let(:auth_hash) {{ provider: 'identity', uid: '1', info: { name: 'GT' }}}
    let(:authentication) { double }
    let(:user) { double }

    before do
      authentication_const.stub(:find_by_provider_and_uid) { authentication }
    end

    context 'creating a new user' do
      before do
        authentication.should_receive(:try).with(:user) { nil }
        user_const.should_receive(:new) { user }
        user.should_receive(:authentications) { authentication }
        authentication.should_receive(:build)
        user.should_receive(:save!)
      end

      it { should == user }
    end

    context 'finding an existing user' do
      before do
        authentication.should_receive(:try).with(:user) { user }
      end

      it { should == user }
    end
  end
end
