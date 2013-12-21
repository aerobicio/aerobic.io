require_relative "../../../app/view_controllers/activity/added_workout_view"

describe Activity::AddedWorkoutView do
  let(:view) { described_class.new(current_member, added_workout) }
  let(:current_member) { double(:current_member) }
  let(:another_member) { double(:another_member, :name => "Gus") }
  let(:member) { another_member }

  let(:added_workout) do
    double(:added_workout, :cache_key => "foo",
                           :activity_workout => activity_workout,
                           :activity_user => member,
          )
  end

  let(:activity_workout) do
    double(:activity_workout, :cache_key => "bar",
                              :active_duration => 100000,
                              :distance => 200000,
          )
  end

  describe "cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should be contain the added workout and activity workout cache keys" do
      cache_key.should == "foo:bar"
    end
  end

  describe "title" do
    subject { view.title }

    context "when current_member added the activity" do
      let(:member) { current_member }

      it { should == "You did a workout:" }
    end

    context "when another member added the activity" do
      let(:member) { another_member }

      it { should == "#{another_member.name} did a workout:" }
    end
  end

  describe "duration" do
    subject { view.duration }

    it { should == "1 minutes" }
  end

  describe "distance" do
    subject { view.distance }

    it { should == "2.0km" }
  end
end
