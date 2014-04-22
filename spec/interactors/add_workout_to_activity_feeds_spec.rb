require 'load_paths_helper'
require 'add_workout_to_activity_feeds'

describe AddWorkoutToActivityFeeds do
  let(:context) do
    {
      workout: workout,
      member_id: 1
    }
  end

  let(:member) { double(:member, id: 1, followers: followers) }
  let(:followers) { [follower] }
  let(:follower) { double(:follower, id: 3) }
  let(:workout) { double(:workout, id: 2) }

  let(:member_params) do
    {
      user_id: context[:member_id],
      activity_user_id: context[:member_id],
      activity_workout_id: workout.id
    }
  end

  let(:follower_params) do
    {
      user_id: follower.id,
      activity_user_id: context[:member_id],
      activity_workout_id: workout.id
    }
  end

  before do
    stub_const('User', Class.new)
    stub_const('Activity::AddedWorkout', Class.new)
  end

  describe '#perform' do
    subject(:result) { described_class.perform(context) }
    let(:activity) { double(:activity, save: activity_persisted) }

    before do
      Activity::AddedWorkout.should_receive(:new).with(member_params) do
        activity
      end
    end

    context 'when successfull' do
      let(:activity_persisted) { true }

      before do
        User.should_receive(:find).with(context[:member_id]) { member }
        Activity::AddedWorkout.should_receive(:new).with(follower_params) do
          activity
        end
      end

      it 'should be marked as successfull' do
        result.success?.should be_true
      end
    end

    context 'when unsuccessfull' do
      let(:activity_persisted) { false }

      it 'should be marked as successfull' do
        result.success?.should be_false
      end
    end
  end
end
