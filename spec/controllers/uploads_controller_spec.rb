require 'spec_helper'

describe UploadsController do
  let(:user) { double(User, id: 42) }

  before do
    session[:user_id] = 1
    User.stub(:find).and_return(user)
  end

  describe "#show" do
    before do
      get :show
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
