require "spec_helper"

describe CreateWorkoutFromUploadedFitFile do
  subject(:result) { described_class.perform(context) }

  let(:context) do
    {
      activity: uploaded_activity,
      member_id: 1,
      device_id: "123",
      device_workout_id: "321"
    }
  end

  let(:activity_file) { double(:activity_file) }

  before do
    FitFile.stub(:new) { activity_file.as_null_object }
  end

  context "Fit File is processed" do
    let(:workout) { double(:workout, id: 1, persisted?: workout_persisted) }

    before do
      Workout.should_receive(:create) { workout }
    end

    context "and Workout is created" do
      let(:workout_persisted) { true }

      context "and fitfile is persisted" do

        before do
          activity_file.should_receive(:save) { true }
        end

        it "should add the workout to the context" do
          result.workout.should == workout
        end

        context "and Workout is added to activity feeds" do
          let(:member) { double(:member, followers: followers) }
          let(:followers) { [follower] }
          let(:follower) { double(:follower, id: 2) }
          let(:activity) { double(:activity, save: activity_persisted) }
          let(:activity_persisted) { true }

          before do
            Activity::AddedWorkout.stub(:new) { activity }
            User.should_receive(:find).with(context[:member_id]) { member }
          end

          it "should be marked as succesful" do
            result.success?.should be_true
          end
        end

        context "but Workout could not be added to activity feeds" do
          let(:activity) { double(:activity, save: activity_persisted) }
          let(:activity_persisted) { false }

          before do
            Activity::AddedWorkout.stub(:new) { activity }
          end

          it "should not be marked as succesful" do
            result.success?.should be_false
          end
        end
      end

      context "but fitfile is not persisted" do
        before do
          activity_file.should_receive(:save) { false }
        end

        it "should not be marked as succesful" do
          result.success?.should be_false
        end
      end
    end

    context "but Workout is not created" do
      let(:workout_persisted) { false }

      it "should not be marked as succesful" do
        result.success?.should be_false
      end
    end
  end

  context "Fit File could not be processed" do
    let(:context) do
      {
      }
    end

    it "should not be marked as succesful" do
      result.success?.should be_false
    end

    it "should add the notice to the context" do
      result.notice.should == "No Fit File found"
    end
  end
end
