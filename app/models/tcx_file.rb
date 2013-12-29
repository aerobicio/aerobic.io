require 'tcx'
require_relative 'workout'

# TcxFile represents an uploaded TCX file. It has a name and a stores the
# xml data blob uploaded by the user.
class TcxFile < ActiveRecord::Base
  belongs_to :workout

  validates :xml_data, presence: true
  validates :workout_id, uniqueness: true

  def active_duration
    to_tcx.active_duration
  end

  def distance
    to_tcx.distance
  end

  def duration
    to_tcx.active_duration
  end

  def end_time
    to_tcx.end_time
  end

  def start_time
    to_tcx.end_time
  end

  private

  def to_tcx
    @tcx ||= Tcx.parse(xml_data)
  end
end
