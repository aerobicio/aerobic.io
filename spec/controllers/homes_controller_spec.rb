require 'spec_helper'

describe HomesController do
  context "when not authenticated" do
    describe "#show" do
      before do
        get :show
      end

      it { should respond_with(:success) }
      it { should render_template(:show) }
    end
  end

  context "when already authenticated" do
    describe "#show" do
      let(:user) { double(User, id: 42) }

      before do
        session[:user_id] = 42
        User.stub(:find).and_return(user)

        get :show
      end

      it { should redirect_to(dashboard_path) }
    end
  end
end
