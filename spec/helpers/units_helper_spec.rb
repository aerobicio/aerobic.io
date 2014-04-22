require 'load_paths_helper'
require 'units_helper'

include UnitsHelper

describe UnitsHelper do
  describe '#format_duration' do
    subject { format_duration(duration) }
    let(:duration) { 600_00 }

    it { should == '0:01:00' }
  end

  describe '#format_distance' do
    subject { format_distance(distance) }
    let(:distance) { 100_000 }

    before do
      I18n.should_receive(:t).with('units.distance', distance: 1.0) { '1.0 km'}
    end

    it { should == '1.0 km' }
  end
end
