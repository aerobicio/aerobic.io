require 'spec_helper'
require_relative '../../app/helpers/units_helper'

describe UnitsHelper do
  describe '#format_duration' do
    subject { format_duration(duration) }
    let(:duration) { 600_00 }

    it { should == '0:01:00' }
  end

  describe '#format_distance' do
    subject { format_distance(distance) }
    let(:distance) { 100_000 }

    it { should == '1.0 km' }
  end
end
