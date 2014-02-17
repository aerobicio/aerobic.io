require_relative '../../app/interactors/authenticate_member'

describe AuthenticateMember do
  describe '#perform' do
    subject(:result) { described_class.perform(auth_hash) }

    let(:auth_hash) { { provider: 'identity', uid: '1', info: { name: 'GT' } } }
    let(:authentication) { double(:authentication, user: user) }
    let(:user) { double(:user, id: 1) }

    before do
      stub_const('Authentication', Class.new)
      stub_const('User', Class.new)
    end

    context 'when authentication exists' do
      before do
        Authentication.should_receive(:find_by_provider_and_uid) do
          authentication
        end
      end

      it 'should be successful' do
        result.success?.should be_true
      end

      it 'should add the user_id to the resulting context' do
        result.user_id.should == user.id
      end
    end

    context 'when authentication does not exist' do
      before do
        Authentication.should_receive(:find_by_provider_and_uid) { nil }
        User.should_receive(:new) { user }
        user.should_receive(:authentications) { authentication }
        authentication.should_receive(:build)
        user.should_receive(:save) { save }
      end

      context 'successfully creating a new user' do
        let(:save) { true }

        it 'should be successful' do
          result.success?.should be_true
        end

        it 'should add the user_id to the resulting context' do
          result.user_id.should == user.id
        end
      end

      context 'unsuccessfully creating a new user' do
        let(:save) { false }

        it 'should be unsuccessful' do
          result.success?.should be_false
        end

        it 'should not add the user_id to the resulting context' do
          result.try(:user_id).should == nil
        end
      end
    end
  end
end
