require 'spec_helper'

describe WorkoutsController do
  let(:user) { double(User, id: 42, email: 'lol@lol.com') }

  before do
    session[:user_id] = 42
    User.stub(:find).with(42).and_return(user)
  end

  describe '#show' do
    let(:member) { double(:member, id: 1) }
    let(:workout) { double(:workout, id: 101) }

    before do
      Workout.should_receive(:find_by!).with(
        user_id: member.id,
        id: workout.id
      ) { workout }
      get :show, member_id: 1, id: 101
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
