require 'load_paths_helper'
require 'activity/added_workout_view'

describe Activity::AddedWorkoutView do
  let(:view) { described_class.new(current_member, added_workout) }
  let(:current_member) { double(:current_member) }
  let(:another_member) { double(:another_member, name: 'Gus') }
  let(:member) { another_member }

  let(:added_workout) do
    double(:added_workout, cache_key: 'foo',
                           activity_workout: activity_workout,
                           activity_user: member
          )
  end

  let(:activity_workout) do
    double(:activity_workout, cache_key: 'bar',
                              active_duration: 100_000,
                              distance: 200_000,
                              sport?: false
          )
  end

  describe 'cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be contain the added workout and activity workout cache keys' do
      cache_key.should == 'foo:bar'
    end
  end

  describe '#title' do
    subject { view.title }

    let(:name) { 'Name' }
    let(:title) { 'Name did a workout' }
    let(:i18n_params) { ['activity.workout.title.default', name: name] }

    before do
      another_member.should_receive(:name_in_context_of) { name }
      I18n.should_receive(:t).with(*i18n_params) { title }
    end

    it { should == title }
  end

  describe 'duration' do
    subject { view.duration }

    it { should == '0:01:40' }
  end

  describe 'distance' do
    subject { view.distance }

    before do
      I18n.should_receive(:t).with('units.distance', distance: 2.0) { '2.0 km' }
    end

    it { should == '2.0 km' }
  end
end
