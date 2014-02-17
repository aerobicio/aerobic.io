require_relative "../../../app/view_controllers/workouts/workout_partial_view"

describe Workouts::WorkoutPartialView do
  let(:view) { described_class.new(current_member, workout) }
  let(:current_member) { double(:current_member, cache_key: "foo") }
  let(:workout_member) { double(:workout_member, name: "Mike") }

  let(:workout) do
    double(:workout, user: workout_member,
                     cache_key: "lol",
                     active_duration: 999_999,
                     distance: 444_444,
          )
  end

  describe "#cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should include the workouts cache_key" do
      cache_key.include?(workout.cache_key).should be_true
    end

    it "should include the current members cache key" do
      cache_key.include?(current_member.cache_key).should be_true
    end
  end

  describe "#title" do
    subject { view.title }

    before do
      I18n.should_receive(:t).with(*i18n_params) { title }
    end

    context "when current member did the workout" do
      let(:workout_member) { current_member }
      let(:title) { "You did a workout" }
      let(:i18n_params) { ["activity.workout.title.first_person"] }

      it { should == title }
    end

    context "when current member did not do the workout" do
      let(:title) { "Mike did a workout" }
      let(:i18n_params) do
        ["activity.workout.title.third_person", name: workout_member.name]
      end

      it { should == title }
    end
  end
end
