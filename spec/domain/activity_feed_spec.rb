require "ostruct"
require_relative "../../app/domain/activity_feed"

describe Domain::ActivityFeed do
  let(:user_id) { 42 }
  let(:score) { 1000 }
  let(:workout_key) { "redis:workout:key" }

  before do
    $redis ||= double(:redis)
  end

  describe ".add_workout(user_id, score, workout_key" do
    before do
      $redis.should_receive(:zadd)
            .with(described_class.redis_key(user_id), score, workout_key)
    end

    it "should add they key to the activity feeds sorted set" do
      described_class.add_workout(user_id, score, workout_key)
    end
  end

  describe ".workouts(user_id)" do
    subject(:workouts) { described_class.workouts(user_id) }

    let(:data_object_1) { OpenStruct.new(id: 1) }
    let(:data_object_2) { OpenStruct.new(id: 2) }

    before do
      $redis.should_receive(:zrevrange)
            .with(described_class.redis_key(user_id), 0, -1) { ["1", "2"] }
      $redis.should_receive(:get).with("1") { data_object_1 }
      $redis.should_receive(:get).with("2") { data_object_2 }
    end

    it "should contain 2 workouts" do
      workouts.length.should == 2
      workouts.first.is_a?(Domain::Workout).should be_true
      workouts.last.is_a?(Domain::Workout).should be_true
    end
  end

  describe ".redis_key(user_id)" do
    subject { described_class.redis_key(user_id) }

    it { should == "user:#{user_id}:activity" }
  end
end
