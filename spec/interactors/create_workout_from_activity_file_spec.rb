require 'active_support/core_ext/object/try'
require_relative '../../app/interactors/create_workout_from_activity_file'

describe CreateWorkoutFromActivityFile do
  subject(:result) { described_class.perform(context) }

  let(:context) do
    {
      member_id: 1,
      device_id: 2,
      device_workout_id: 3,
      activity_file: activity_file
    }
  end

  let(:activity_file) do
    double(:activity_file, save: activity_file_persisted).as_null_object
  end

  let(:workout_creator) { double(:workout_creator) }
  let(:workout) { double(:workout, id: 1, persisted?: persisted) }

  before do
    stub_const('WorkoutCreator', Class.new)
    WorkoutCreator.should_receive(:new) { workout_creator }
    workout_creator.should_receive(:persist_workout) { workout }
    activity_file.should_receive(:workout_id=).with(workout.id)
  end

  context 'when workout is persisted' do
    let(:persisted) { true }

    context 'and activity file is persisted' do
      let(:activity_file_persisted) { true }

      it 'should be marked as successfull' do
        result.success?.should be_true
      end

      it 'should add workout to the context' do
        result.workout.should == workout
      end
    end

    context 'and activity file is not persisted' do
      let(:activity_file_persisted) { false }

      it 'should not be marked as successfull' do
        result.success?.should be_false
      end

      it 'should not add workout to the context' do
        result.try(:workout).should eql(nil)
      end
    end
  end

  context 'when unsuccessfull' do
    let(:persisted) { false }
    let(:activity_file_persisted) { false }

    it 'should not be marked as successfull' do
      result.success?.should be_false
    end

    it 'should not add workout to the context' do
      result.try(:workout).should eql(nil)
    end
  end
end
