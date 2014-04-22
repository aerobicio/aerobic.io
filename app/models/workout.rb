require 'tcx_file'
require 'user'

# Represents a workout in the database.
#
class Workout < ActiveRecord::Base
  has_one :tcx_file
  belongs_to :user

  validates :active_duration, :distance, :duration,  presence: true
  validates :end_time, :start_time, :user, presence: true

  scope :desc, lambda {
    order(start_time: :desc)
  }

  def date
    start_time.to_date
  end
end
