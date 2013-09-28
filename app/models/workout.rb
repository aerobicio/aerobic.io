require_relative "fit_file"
require_relative "user"

class Workout < ActiveRecord::Base
  has_one :fit_file
  belongs_to :user

  validates :active_duration, :distance, :duration,  presence: true
  validates :end_time, :start_time, :user, presence: true
end
