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
      workouts.should_receive(:load) { [] }
      user.should_receive(:workouts) { workouts }
      get :show
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe "#create" do
    context "when given a fit file" do
      before do
        CreateWorkoutFromUploadedFitFile.should_receive(:perform) { result }
        post :create, { activity_type: "fit", format: :json }
      end

      context "and the context returns successfully" do
        let(:result) { double(:result, success?: true ) }

        it { should respond_with(:success) }
      end

      context "and the context returns unsuccessfully" do
        let(:result) { double(:result, success?: false ) }

        it { should respond_with(:success) }
      end
    end

    context "when given a tcx file" do
      before do
        ProcessUploadedTcxFile.should_receive(:perform) { result }
        post :create, { activity_type: "tcx", format: :json }
      end

      context "and the context returns successfully" do
        let(:result) { double(:result, success?: true ) }

        it { should respond_with(:success) }
      end

      context "and the context returns unsuccessfully" do
        let(:result) { double(:result, success?: false ) }

        it { should respond_with(:success) }
      end
    end
  end
end
