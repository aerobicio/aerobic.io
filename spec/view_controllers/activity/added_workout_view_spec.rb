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

      it { should == I18n.t("activity.workout.title.first_person") }
    end

    context "when another member added the activity" do
      let(:member) { another_member }

      it { should == I18n.t("activity.workout.title.third_person",
        name: another_member.name) }
    end
  end

  describe "duration" do
    subject { view.duration }

    it { should == "0:01:40" }
  end

  describe "distance" do
    subject { view.distance }

    it { should == "2.0 km" }
  end
end
