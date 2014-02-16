require 'spec_helper'

describe UploadsController do
  let(:user) { double(User, id: 42) }
  let(:user_workouts) { double() }

  before do
    session[:user_id] = 1
    User.stub(:find).and_return(user)
  end

  describe "#show" do
    before do
      user.should_receive(:workouts) { user_workouts }
      user_workouts.should_receive(:load) { [] }
      get :show
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
