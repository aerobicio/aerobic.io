require 'load_paths_helper'
require 'workouts/workout_partial_view'

describe Workouts::WorkoutPartialView do
  let(:view) { described_class.new(context, current_member, workout) }
  let(:context) { double(:context) }
  let(:current_member) { double(:current_member, cache_key: 'foo', id: 1) }
  let(:workout_member) { double(:workout_member, name: 'Mike', id: 2) }

  let(:workout) do
    double(:workout, id: 1,
                     user: workout_member,
                     cache_key: 'lol',
                     active_duration: 999_999,
                     distance: 444_444
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

    context 'when current member did the workout' do
      let(:workout_member) { current_member }
      let(:title) { 'You did a workout' }

      before do
        context.should_receive(:link_to)
          .with('You', '/members/1')
          .once { 'You' }
        context.should_receive(:link_to)
          .with(I18n.t('workouts.title.object'), '/members/1/workouts/1')
          .once { I18n.t('workouts.title.object') }
      end

      it { should == title }
    end

    context 'when current member did not do the workout' do
      let(:title) { 'Mike did a workout' }

      before do
        context.should_receive(:link_to)
          .with('Mike', '/members/2')
          .once { 'Mike' }
        context.should_receive(:link_to)
          .with(I18n.t('workouts.title.object'), '/members/2/workouts/1')
          .once { I18n.t('workouts.title.object') }
      end

      it { should == title }
    end
  end
end
