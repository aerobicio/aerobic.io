require "spec_helper"

describe MembersController do
  let(:user) { Domain::Member.new(double(User, id: 42)) }

  before do
    session[:user_id] = 42
    Domain::Member.stub(:find).and_return(user)
  end

  describe "#index" do

    @following
    context "when following is turned off" do
      before do
        $switch_board.deactivate_following
        get :index
      end

      it { should respond_with(:not_found) }
    end

    @following
    context "when following is turned on" do
      before do
        $switch_board.activate_following
        Domain::Member.should_receive(:all) { [] }
        get :index
      end

      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end

  describe "follow" do
    @following
    context "when following is turned off" do
      before do
        $switch_board.deactivate_following
        post :follow, id: 22
      end

      it { should redirect_to(dashboard_path) }
    end

    @following
    context "when following is turned on" do
      let(:user_2) { Domain::Member.new(double(User, id: 22, name: "Justin")) }

      before do
        $switch_board.activate_following
        Domain::Member.should_receive(:find).with("22") { user_2 }
        user.should_receive(:follow).with(user_2) { true }
        post :follow, id: 22
      end

      it { should set_the_flash[:notice].to("Now following #{user_2.name}") }
      it { should redirect_to(members_path) }
    end
  end
end
