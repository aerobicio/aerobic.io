require_relative "../../lib/display_time"

describe DisplayTime do
  let(:display_time) { DisplayTime.new(duration) }

  describe "#hours" do
    subject { display_time.hours }
    let(:duration) { 4985 } # 1:23:05

    it "should calculate hours from duration" do
      should == 1
    end
  end

  describe "#minutes" do
    subject { display_time.minutes }

    let(:duration) { 4985 } # 1:23:05

    it "should calculate minutes from duration" do
      should == 23
    end
  end

  describe "#seconds" do
    subject { display_time.seconds }

    let(:duration) { 4985 } # 1:23:05

    it "should calculate seconds from duration" do
      should == 5
    end
  end
end
