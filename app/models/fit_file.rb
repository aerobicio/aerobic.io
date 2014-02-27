require 'fit'
require_relative 'workout'

# FitFile represents an uploaded FIT file. It has a name and a stores the
# binary data blob uploaded by the user.
class FitFile < ActiveRecord::Base
  belongs_to :workout

  validates :binary_data, :name, presence: true
  validates :workout_id, uniqueness: true

  delegate :active_duration, :distance, :duration, to: :fit

  def end_time
    Time.zone.at(fit.end_time) if fit.end_time
  end

  def start_time
    Time.zone.at(fit.start_time) if fit.start_time
  end

  private

  def fit
    @fit ||= begin
               Fit::File.read(StringIO.new(binary_data))
             rescue EOFError
               NullFitFile.new
             end
  end

  # A null representation of a Fit::File that is substituted when a Fit::File
  # cannot be processed.
  #
  class NullFitFile
    attr_reader :active_duration, :distance, :duration, :start_time, :end_time
  end
end
