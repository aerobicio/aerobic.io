class Workout < ActiveRecord::Base
  has_one :fit_file

  validates :active_duration, :distance, :duration,  presence: true
  validates :end_time, :start_time, presence: true
end
