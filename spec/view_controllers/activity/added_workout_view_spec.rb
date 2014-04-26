require 'load_paths_helper'
require 'activity/added_workout_view'

describe Activity::AddedWorkoutView do
  let(:view) { described_class.new(context, current_member, added_workout) }
  let(:current_member) { double(:current_member, id: 1) }
  let(:another_member) { double(:another_member, id: 2, name: 'Gus') }
  let(:member) { another_member }
  let(:context) { double }

  let(:added_workout) do
    double(:added_workout, id: 1,
                           cache_key: 'foo',
                           activity_workout: activity_workout,
                           activity_user: member
          )
  end

  let(:activity_workout) do
    double(:activity_workout, id: 1,
                              cache_key: 'bar',
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

    before do
      member.should_receive(:id)
      activity_workout.should_receive(:id)
    end

    context 'when current_member added the activity' do
      let(:member) { current_member }
      let(:title) do
        '<a href="/members/1">You</a> added <a href="/members/1/workouts/1>a workout</a>'
      end

      before do
        member.should_receive(:name_in_context_of).with(current_member) { 'You' }
        context.should_receive(:link_to).with('You', '/members/1') do
          '<a href="/members/1">You</a>'
        end
        context.should_receive(:link_to).with('a workout', '/members/1/workouts/1') do
          '<a href="/members/1/workouts/1>a workout</a>'
        end
      end

      it { should == title }
    end

    context 'when another member added the activity' do
      let(:member) { another_member }
      let(:title) do
        '<a href="/members/2">Gus</a> added <a href="/members/2/workouts/1>a workout</a>'
      end

      before do
        member.should_receive(:name_in_context_of).with(current_member) { 'Gus' }
        context.should_receive(:link_to).with('Gus', '/members/2') do
          '<a href="/members/2">Gus</a>'
        end
        context.should_receive(:link_to).with('a workout', '/members/2/workouts/1') do
          '<a href="/members/2/workouts/1>a workout</a>'
        end
      end

      it { should == title }
    end
  end

  describe 'duration' do
    subject { view.duration }

    it { should == '0:01:40 hr' }
  end

  describe 'distance' do
    subject { view.distance }

    before do
      I18n.should_receive(:t).with('units.distance.kilometers', kilometers: 2.0) { '2.0 km' }
    end

    it { should == '2.0 km' }
  end
end
