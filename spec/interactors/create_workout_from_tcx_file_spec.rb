require "active_support/core_ext/object/try"
require_relative "../../app/interactors/create_workout_from_tcx_file"

describe CreateWorkoutFromTcxFile do
  subject(:result) { described_class.perform(context) }

  let(:context) do
    {
      tcxfile: tcx_file,
    }
  end

  let(:tcx_file) { double(:tcx_file, save: tcx_file_persisted).as_null_object }
  let(:workout) { double(:workout, id: 1, persisted?: persisted) }

  before do
    stub_const("Workout", Class.new)
    Workout.should_receive(:create) { workout }
    tcx_file.should_receive(:workout_id=).with(workout.id)
  end

  context "when workout is persisted" do
    let(:persisted) { true }

    context "and fit file is persisted" do
      let(:tcx_file_persisted) { true }

      it "should be marked as successfull" do
        result.success?.should be_true
      end

      it "should add workout to the context" do
        result.workout.should == workout
      end
    end

    context "and fit file is not persisted" do
      let(:tcx_file_persisted) { false }

      it "should not be marked as successfull" do
        result.success?.should be_false
      end

      it "should not add workout to the context" do
        result.try(:workout).should == nil
      end
    end
  end

  context "when unsuccessfull" do
    let(:persisted) { false }
    let(:tcx_file_persisted) { false }

    it "should not be marked as successfull" do
      result.success?.should be_false
    end

    it "should not add workout to the context" do
      result.try(:workout).should == nil
    end
  end
end
