require 'spec_helper'

describe MembersController do
  let(:user) { double(User, id: 42) }

  before do
    session[:user_id] = 42
    User.stub(:find).with(42).and_return(user)
  end

  describe '#index' do
    before do
      get :index
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe '#show' do
    let(:member) { double(:member, activities: []) }

    before do
      User.should_receive(:find).with('1') { member }
      get :show, id: 1
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe 'follow' do
    @following
    context 'when following is turned off' do
      before do
        $switch_board.deactivate_following
        post :follow, id: 22
      end

      it { should respond_with(:not_found) }
    end

    @following
    context 'when following is turned on' do
      before do
        $switch_board.activate_following
        FollowMember.should_receive(:perform) { result }
        post :follow, id: 22
      end

      let(:result) do
        double(:result, success?: true,
                        notice: 'My Notice')
      end

      it { should set_the_flash[:notice].to('My Notice') }
      it { should redirect_to(members_path) }
    end
  end

  describe 'unfollow' do
    @following
    context 'when following is turned off' do
      before do
        $switch_board.deactivate_following
        post :unfollow, id: 22
      end

      it { should respond_with(:not_found) }
    end

    @following
    context 'when following is turned on' do
      before do
        $switch_board.activate_following
        UnFollowMember.should_receive(:perform) { result }
        post :unfollow, id: 22
      end

      let(:result) do
        double(:result, success?: true,
                        notice: 'My Notice')
      end

      it { should set_the_flash[:notice].to('My Notice') }

      it { should redirect_to(members_path) }
    end
  end
end
