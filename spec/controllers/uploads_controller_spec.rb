require 'spec_helper'

describe UploadsController do
  let(:user) { double(User, id: 42) }
  let(:workouts) { double() }

  before do
    session[:user_id] = 1
    User.stub(:find).and_return(user)
  end

  describe "#show" do
    before do
      workouts.should_receive(:all) { [] }
      user.should_receive(:workouts) { workouts }
      get :show
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
