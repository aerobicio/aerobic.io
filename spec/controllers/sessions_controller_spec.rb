require "spec_helper"

describe SessionsController do
  describe "#create" do
    let(:user) { double(id: 1) }

    before do
      auth_hash = { provider: 'identity', uid: 1, info: { name: 'GT' }}
      @request.env['omniauth.auth'] = auth_hash
      AuthenticateMember.should_receive(:perform) { result }
      post :create
    end

    context "successfully" do
      let(:result) do
        double(:result,  success?: true,
                         user_id: 1)
      end

      it "should set the user_id in the session" do
        session[:user_id].should == user.id
      end

      it { should redirect_to(dashboard_path) }
    end

    context "unsuccessfully" do
      let(:result) do
        double(:result,  success?: false)
      end

      it "should set the user_id in the session" do
        session[:user_id].should == nil
      end

      it { should render_template(:new) }
    end
  end

  describe 'destroy' do
    before do
      put :destroy
    end

    it { should_not set_session(:user_id) }
    it { should redirect_to(:root) }
  end
end
