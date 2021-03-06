require 'load_paths_helper'
require 'support/active_record_array_with_kaminari'
require 'dashboards/show'

describe Dashboards::Show do
  let(:view) { described_class.new(controller, member) }
  let(:controller) { double(:controller) }
  let(:member) { double(:member, activities: member_activities) }

  let(:member_activities) do
    ActiveRecordArrayWithKaminari.new([activity_1, activity_2])
  end

  let(:activity_1) { double(:activity_1, cache_key: 1, date: Date.today) }
  let(:activity_2) { double(:activity_2, cache_key: 2, date: Date.today) }

  describe '#cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be a concatination of the members activities cache keys' do
      cache_key.should == '1:2'
    end
  end

  describe '#render_activities' do
    subject(:render_activities) { view.render_activities }

    let(:render_params) do
      {
        partial: 'activity/grouped',
        object: { Date.today =>  member_activities.page },
        locals: { activities: member_activities.page }
      }
    end

    context 'when the member has activities' do
      let(:member_activities) do
        ActiveRecordArrayWithKaminari.new([activity_1])
      end

      before do
        controller.should_receive(:render).with(render_params) do
          'render'
        end
      end

      it 'should render the activities' do
        render_activities.should == 'render'
      end
    end

    context 'when the member has no activities' do
      let(:member_activities) { ActiveRecordArrayWithKaminari.new([]) }

      it 'should render a message stating so' do
        render_activities.should == 'You have no activity!'
      end
    end
  end
end
