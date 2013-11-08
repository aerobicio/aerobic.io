shared_examples "an activity model" do
  it { should belong_to(:user) }
  it { should belong_to(:activity_user) }
  it { should belong_to(:activity_workout) }
  it { should belong_to(:activity_followed_user) }

  it { should validate_presence_of(:user) }
end

shared_examples "an activity models public API" do
end
