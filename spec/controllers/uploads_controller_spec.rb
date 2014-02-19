require 'spec_helper'

describe UploadsController do
  let(:user) { double(User, id: 42) }
  let(:user_workouts) { double() }

  let(:workout) do
    double(:workout, attributes: { distance: 123,
                                   active_duration: 123,
                                   duration: 123
                                 },
                     distance: 123,
                     active_duration: 123,
                     duration: 123
          )
  end

  before do
    session[:user_id] = 1
    User.stub(:find).and_return(user)
  end

  describe "#show" do
    before do
      user.should_receive(:workouts) { user_workouts }
      user_workouts.should_receive(:load) { [workout] }

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
        let(:result) do
          double(:result, success?: true, context: { workout: "" } )
        end

        it { should respond_with(:success) }
      end

      context "and the context returns unsuccessfully" do
        let(:result) { double(:result, success?: false ) }

        it { should respond_with(:unprocessable_entity) }
      end
    end

    context "when given a tcx file" do
      before do
        CreateWorkoutFromUploadedTcxFile.should_receive(:perform) { result }
        post :create, { activity_type: "tcx", format: :json }
      end

      context "and the context returns successfully" do
        let(:result) do
          double(:result, success?: true, context: { workout: "" } )
        end

        it { should respond_with(:success) }
      end

      context "and the context returns unsuccessfully" do
        let(:result) { double(:result, success?: false ) }

        it { should respond_with(:unprocessable_entity) }
      end
    end

    context "when given an unknown file" do
      before do
        post :create, { format: :json }
      end

      it { should respond_with(:unprocessable_entity) }
    end
  end
end
