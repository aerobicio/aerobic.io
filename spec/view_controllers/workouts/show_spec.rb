require 'load_paths_helper'
require 'workouts/show'

describe Workouts::Show do
  let(:view) { described_class.new(controller, member_id, workout_id) }
  let(:controller) { double(:controller) }
  let(:member) { double(:member) }
  let(:member_id) { 1 }
  let(:workout_id) { 2 }

  let(:workout) do
    double(:workout,
           id: workout_id,
           user: member,
           cache_key: workout_id.to_s,
           active_duration: 600_00,
           distance: 100_000
          )
  end

  before do
    stub_const('Workout', Class.new)
    Workout.should_receive(:find_by!).with(
      user_id: member_id,
      id: workout_id
    ) { workout }
  end

  describe '#cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be a combination of the member and workout cache keys' do
      cache_key.should == '2'
    end
  end

  describe '#duration' do
    subject(:duration) { view.duration }

    it 'returns the formatted workout duration' do
      duration.should == '0:01:00 hr'
    end
  end

  describe '#distance' do
    subject(:distance) { view.distance }

    before do
      I18n.should_receive(:t).with('units.distance.kilometers',
                                   kilometers: 1.0) { '1.0 km' }
    end

    it 'returns the formatted workout distance' do
      distance.should == '1.0 km'
    end
  end

  describe '#member' do
    subject { view.member }

    it { should == member }
  end
end
