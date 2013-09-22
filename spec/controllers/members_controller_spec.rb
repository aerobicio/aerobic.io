require "spec_helper"

describe MembersController do
  let(:user) { Domain::Member.new(double(User, id: 42)) }

  before do
    session[:user_id] = 42
    Domain::Member.stub(:find).and_return(user)
  end

  describe "#index" do
    before do
      get :index
    end

    it { should respond_with(:not_found) }
  end
end
