require 'spec_helper'

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
                              distance: 200_000
          )
  end

  describe 'cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be contain the added workout and activity workout cache keys' do
      cache_key.should == 'foo:bar'
    end
  end

  describe 'title' do
    subject { view.title }

    before do
      member.should_receive(:id)
      activity_workout.should_receive(:id)
    end

    context 'when current_member added the activity' do
      let(:member) { current_member }

      before do
        context.should_receive(:link_to).with('You', '/members/1').once
        context.should_receive(:link_to).with(I18n.t('activity.added_workout.object'), '/members/1/workouts/1').once
      end

      # it { should == I18n.t('activity.title.first_person') }
    end

    context 'when another member added the activity' do
      let(:member) { another_member }

      before do
        member.should_receive(:name)
        context.should_receive(:link_to).with('Gus', '/members/2').once
        context.should_receive(:link_to).with(I18n.t('activity.added_workout.object'), '/members/2/workouts/1').once
      end

      # it 'should use the third person' do
      #   subject.should == I18n.t('activity.title.third_person',
      #                            name: another_member.name)
      # end
    end
  end

  describe 'duration' do
    subject { view.duration }

    it { should == '0:01:40' }
  end

  describe 'distance' do
    subject { view.distance }

    it { should == '2.0 km' }
  end
end
