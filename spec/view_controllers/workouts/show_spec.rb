require "spec_helper"
require_relative "../../../app/view_controllers/workouts/show"

describe Workouts::Show do
  let(:view) { described_class.new(controller, current_member, workout_id) }
  let(:controller) { double(:controller) }
  let(:current_member) { double(:current_member, id: 1, cache_key: "1") }
  let(:workout_id) { 2 }

  let(:workout) do
    double(:workout,
           id: workout_id,
           cache_key: workout_id.to_s,
           active_duration: 60000,
           distance: 100000,
          )
  end

  before do
    stub_const("Workout", Class.new)
    Workout.should_receive(:find_by!).with(
      user_id: current_member.id,
      id: workout_id,
    ) { workout }
  end

  describe "#cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should be a combination of the member and workout cache keys" do
      cache_key.should == "1:2"
    end
  end

  describe "#duration" do
    subject(:duration) { view.duration }

    it "returns the formatted workout duration" do
      duration.should == "1 min"
    end
  end

  describe "#distance" do
    subject(:distance) { view.distance }

    it "returns the formatted workout distance" do
      distance.should == "1.0 km"
    end
  end
end
