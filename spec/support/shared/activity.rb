shared_examples "an activity model" do
  it { should belong_to(:user) }
  it { should belong_to(:activity_user) }
  it { should belong_to(:activity_workout) }
  it { should belong_to(:activity_followed_user) }

  it { should validate_presence_of(:user) }
end

shared_examples "an activity models public API" do
  let(:activity) { described_class.new }

  describe "#date" do
    subject { activity.date }

    context "when created_at is not set" do
      it { should == nil }
    end

    context "when created_at is set" do
      let(:time) { Time.now }

      before do
        activity.created_at = time
      end

      it { should == time.to_date }
    end
  end
end
