require 'display_time'
require 'i18n'

# UnitsHelper provides standard ways of converting data from base units into
# common formatting for presentation to users
module UnitsHelper
  def format_duration(duration_ms)
    DisplayTime.new(milliseconds_to_seconds(duration_ms)).to_s
  end

  def format_distance(distance_cm)
    I18n.t('units.distance', distance: centimeters_to_kilometers(distance_cm))
  end

  private

  def milliseconds_to_seconds(ms)
    ms / 1000
  end

  def centimeters_to_kilometers(cm)
    (cm / 100_000.0).round(2)
  end
end
