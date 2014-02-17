require 'fit'
require_relative 'workout'

# FitFile represents an uploaded FIT file. It has a name and a stores the
# binary data blob uploaded by the user.
class FitFile < ActiveRecord::Base
  belongs_to :workout

  validates :binary_data, :name, presence: true
  validates :workout_id, uniqueness: true

  def active_duration
    to_fit.active_duration
  end

  def distance
    to_fit.distance
  end

  def duration
    to_fit.duration
  end

  def end_time
    Time.zone.at(to_fit.end_time)
  end

  def start_time
   Time.zone.at(to_fit.start_time)
  end

  private

  def to_fit
    @fit ||= Fit::File.read(StringIO.new(binary_data))
  end
end
