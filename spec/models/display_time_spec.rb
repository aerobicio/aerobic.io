require 'load_paths_helper'
require 'display_time'

describe DisplayTime do
  let(:display_time) { DisplayTime.new(duration) }
  let(:duration) { 4985 } # 1:23:05

  describe '#hours' do
    subject { display_time.hours }

    it 'should calculate hours from duration' do
      should == 1
    end
  end

  describe '#minutes' do
    subject { display_time.minutes }

    it 'should calculate minutes from duration' do
      should == 23
    end
  end

  describe '#seconds' do
    subject { display_time.seconds }

    it 'should calculate seconds from duration' do
      should == 5
    end
  end

  describe '#to_s' do
    subject { display_time.to_s }

    it { should == '1:23:05' }
  end
end
