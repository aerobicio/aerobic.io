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

      it { should respond_with(:not_found) }
    end

    @following
    context "when following is turned on" do
      let(:user_2) { Domain::Member.new(double(User, id: 22, name: "Justin")) }

      before do
        $switch_board.activate_following
        FollowMember.should_receive(:perform) { result }
        post :follow, id: 22
      end

      context "and it is successfull" do
        let(:result) do
          double(:result, success?: true,
                          member: user_2)
        end

        it { should set_the_flash[:notice].to("Now following #{user_2.name}") }
        it { should redirect_to(members_path) }
      end

      context "when it is unsuccessfull" do
        let(:result) do
          double(:result, success?: false,
                          member: user_2)
        end

        it do
          should set_the_flash[:notice].to("Could not follow #{user_2.name}")
        end

        it { should redirect_to(members_path) }
      end
    end
  end

  describe "unfollow" do
    @following
    context "when following is turned off" do
      before do
        $switch_board.deactivate_following
        post :unfollow, id: 22
      end

      it { should respond_with(:not_found) }
    end

    @following
    context "when following is turned on" do
      let(:user_2) { Domain::Member.new(double(User, id: 22, name: "Justin")) }

      before do
        $switch_board.activate_following
        UnFollowMember.should_receive(:perform) { result }
        post :unfollow, id: 22
      end

      context "and it is successfull" do
        let(:result) do
          double(:result, success?: true,
                          member: user_2)
        end

        it "should set the flash message" do
          should set_the_flash[:notice].to("No longer following #{user_2.name}")
        end

        it { should redirect_to(members_path) }
      end

      context "and it is unsuccessfull" do
        let(:result) do
          double(:result, success?: false,
                          member: user_2)
        end

        it "should set the flash message" do
          should set_the_flash[:notice].to("Could not unfollow #{user_2.name}")
        end

        it { should redirect_to(members_path) }
      end
    end
  end
end
