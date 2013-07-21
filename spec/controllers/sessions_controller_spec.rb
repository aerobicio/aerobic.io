require "spec_helper"

describe SessionsController do
  describe "#create" do
    let(:user) { double(id: 1) }

    before do
      auth_hash = { provider: 'identity', uid: 1, info: { name: 'GT' }}
      @request.env['omniauth.auth'] = auth_hash
      OmniAuthUser.should_receive(:user_from_auth_hash).with(auth_hash) { user }
      post :create
    end

    it "should set the user_id in the session" do
      session[:user_id].should == user.id
    end

    it { should redirect_to(:root) }
  end

  describe 'destroy' do
    before do
      put :destroy
    end

    it { should_not set_session(:user_id) }
    it { should redirect_to(:root) }
  end
end
