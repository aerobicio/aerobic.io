require 'spec_helper'
require 'workouts/workout_partial_view'

describe Workouts::WorkoutPartialView do
  let(:view) { described_class.new(context, current_member, workout) }
  let(:context) { double(:context) }
  let(:current_member) { double(:current_member, name: 'Justin', cache_key: 'foo', id: 1) }
  let(:workout_member) { double(:workout_member, name: 'Mike', id: 2) }
  # let(:url_helpers) { double }

  let(:workout) do
    double(:workout, id: 1,
                     user: workout_member,
                     cache_key: 'lol',
                     active_duration: 999_999,
                     distance: 444_444,
                     sport?: false
          )
  end

  # before do
  #   view.stub(:url_helpers).and_return(url_helpers)
  # end

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

    context 'when current member did the workout' do
      let(:workout_member) { current_member }
      let(:title) do
        '<a href="/members/1">You</a> did <a href="/members/1/workouts/1>a workout</a>'
      end

      before do
        workout_member.should_receive(:name_in_context_of).with(current_member) { 'You' }
        context.should_receive(:link_to).with('You', '/members/1') do
          '<a href="/members/1">You</a>'
        end
        context.should_receive(:link_to).with('a workout', '/members/1/workouts/1') do
          '<a href="/members/1/workouts/1>a workout</a>'
        end
      end

      it { should == title }
    end

    context 'when current member did not do the workout' do
      let(:title) do
        '<a href="/members/2">Mike</a> did <a href="/members/2/workouts/1>a workout</a>'
      end

      before do
        workout_member.should_receive(:name_in_context_of).with(current_member) { 'Mike' }
        context.should_receive(:link_to).with('Mike', '/members/2') do
          '<a href="/members/2">Mike</a>'
        end
        context.should_receive(:link_to).with('a workout', '/members/2/workouts/1') do
          '<a href="/members/2/workouts/1>a workout</a>'
        end
      end

      it { should == title }
    end
  end
end
