require 'spec_helper'

describe FollowsController do
  let(:user) { double(User, id: 42) }

  before do
    session[:user_id] = 42
    User.stub(:find).with(42).and_return(user)
  end

  describe '#index' do
    let(:member) { double(:member, id: 1) }

    before do
      get :index, member_id: 1
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end
end
