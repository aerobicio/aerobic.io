require "active_record_helper"
require_relative "../support/uploaded_activity"
require_relative "../../app/models/fit_file"
require_relative "../../app/models/user"

describe FitFile do

  context "validations and associations" do
    before do
      FitFile.transaction do
        user = User.create!(name: "Gareth Townsend")
        fit_file = FitFile.new(name: "foo", binary_data: "adf")

        workout = Workout.create!(active_duration: 1,
                                  distance: 1,
                                  duration: 1,
                                  end_time: Time.now,
                                  start_time: Time.now,
                                  user: user)
        fit_file.workout = workout
        fit_file.save!
      end
    end

    it { should belong_to(:workout) }

    it { should validate_presence_of(:binary_data) }
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:workout_id) }
  end

  context "accessing records" do
    before(:all) do
      @fit_file = FitFile.new(binary_data: binaray_activity_data)
      @fit_file.send(:to_fit)
    end

    describe "that are present" do
      subject(:records) { @fit_file.activity_records }

      it { should_not == [] }
    end

    describe "that are not present" do
      subject(:records) { @fit_file.blood_pressure_records }

      it { should == [] }
    end

  end
end
