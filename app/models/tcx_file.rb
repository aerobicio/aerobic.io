require 'tcx'
require 'workout'

# TcxFile represents an uploaded TCX file. It has a name and a stores the
# xml data blob uploaded by the user.
class TcxFile < ActiveRecord::Base
  belongs_to :workout

  validates :xml_data, presence: true
  validates :workout_id, uniqueness: true

  delegate :active_duration, :distance, to: :tcx

  def duration
    tcx.active_duration
  end

  def end_time
    Time.zone.at(tcx.end_time)
  end

  def start_time
    Time.zone.at(tcx.start_time)
  end

  private

  def tcx
    @tcx ||= Tcx.parse(xml_data)
  end
end
