require 'spec_helper'

describe FitFile do
  before do
    FitFile.transaction do
      fit_file = FitFile.new(name: "foo", binary_data: "adf")

      workout = Workout.create!(active_duration: 1,
                                distance: 1,
                                duration: 1,
                                end_time: Time.now,
                                start_time: Time.now)
      fit_file.workout = workout
      fit_file.save!
    end
  end

  it { should belong_to(:workout) }

  it { should validate_presence_of(:binary_data) }
  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:workout_id) }
end
