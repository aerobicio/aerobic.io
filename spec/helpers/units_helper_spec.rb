require "spec_helper"
require_relative "../../app/helpers/units_helper"

describe UnitsHelper do
  describe "#format_duration" do
    subject { format_duration(duration) }
    let(:duration) { 60000 }

    it { should == "1 min" }
  end

  describe "#format_distance" do
    subject { format_distance(distance) }
    let(:distance) { 100000 }

    it { should == "1.0 km" }
  end
end
