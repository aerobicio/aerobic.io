require_relative "../../app/domain/workout"

describe Domain::Workout do
  describe ".new" do
    subject(:workout) { described_class.new }

    it { should be_an_instance_of(Domain::Workout) }
  end
end
