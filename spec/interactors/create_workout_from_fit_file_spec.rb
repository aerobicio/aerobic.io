require_relative "../../app/interactors/create_workout_from_fit_file"

describe CreateWorkoutFromFitFile do
  let(:context) do
    {
      fitfile: fit_file,
    }
  end

  let(:fit_file) { double(:fit_file).as_null_object }
  let(:workout) { double(:workout, id: 1) }

  before do
    stub_const("Workout", Class.new)
  end

  describe "#perform" do
    context "when successfull" do
      subject(:result) { described_class.perform(context) }

      before do
        Workout.should_receive(:create) { workout }
        fit_file.should_receive(:workout_id=).with(workout.id)
        fit_file.should_receive(:save) { true }
      end

      it "should be marked as successfull" do
        result.success?.should be_true
      end

      it "should add workout to the context" do
        result.workout.should == workout
      end
    end
  end
end
