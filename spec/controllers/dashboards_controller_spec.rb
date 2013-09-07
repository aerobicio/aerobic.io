require 'spec_helper'

describe DashboardsController do
  let(:user) { Domain::Member.new(double(User, id: 42)) }

  before do
    session[:user_id] = 1
    Domain::Member.stub(:find).and_return(user)
  end

  describe "#show" do
    before do
      get :show
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
end
