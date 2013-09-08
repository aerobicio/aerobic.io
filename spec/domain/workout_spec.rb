require "ostruct"
require_relative "../../app/domain/workout"

describe Domain::Workout do
  describe ".new" do
    subject(:workout) { described_class.new(data_object) }
    let(:data_object) { OpenStruct.new(id: 42) }

    it { should be_an_instance_of(Domain::Workout) }
    its(:id) { should == data_object.id }

    context "from a json string" do
      let(:data_object) { { id: 42, active_duration: 500 }.to_json }

      it { should be_an_instance_of(Domain::Workout) }
      its(:id) { should == 42 }
      its(:active_duration) { should == 500 }
    end
  end

  describe ".all_for(user_id)" do
    subject(:all_for) { described_class.all_for(user_id) }

    let(:user_id) { 42 }
    let(:workout_class) { double(:workout_class) }
    let(:workouts) { [double.as_null_object, double.as_null_object] }

    before do
      stub_const("Workout", workout_class)
      workout_class.should_receive(:where).with(user_id: user_id) { workouts }
    end

    it "should return an array of Domain::Workout objects" do
      all_for.each { |s| s.should be_an_instance_of(Domain::Workout) }
    end

    it "should return the same number of objects" do
      all_for.length.should == workouts.length
    end
  end
end
