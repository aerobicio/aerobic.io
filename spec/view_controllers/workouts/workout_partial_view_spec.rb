require 'load_paths_helper'
require 'workouts/workout_partial_view'

describe Workouts::WorkoutPartialView do
  let(:view) { described_class.new(current_member, workout) }
  let(:current_member) { double(:current_member, cache_key: 'foo') }
  let(:workout_member) { double(:workout_member, name: 'Mike') }

  let(:workout) do
    double(:workout, user: workout_member,
                     cache_key: 'lol',
                     active_duration: 999_999,
                     distance: 444_444,
                     sport?: false
          )
  end

  describe '#cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should include the workouts cache_key' do
      cache_key.include?(workout.cache_key).should be_true
    end

    it 'should include the current members cache key' do
      cache_key.include?(current_member.cache_key).should be_true
    end
  end

  describe '#title' do
    subject { view.title }

    let(:name) { 'Name' }
    let(:title) { 'Name did a workout' }
    let(:i18n_params) { ['activity.workout.title.default', name: name] }

    before do
      workout_member.should_receive(:name_in_context_of) { name }
      I18n.should_receive(:t).with(*i18n_params) { title }
    end

    it { should == title }
  end
end
