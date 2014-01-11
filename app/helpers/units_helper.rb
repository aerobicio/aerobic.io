# UnitsHelper provides standard ways of converting data from base units into
# common formatting for presentation to users
module UnitsHelper
  def format_duration(duration_ms)
    DisplayTime.new(duration_ms / 1000).to_s
  end

  def format_distance(distance_cm)
    I18n.t("units.distance", distance: centimeters_to_meters(distance_cm))
  end

  private

  def milliseconds_to_minutes(ms)
    ms / 1000 / 60
  end

  def centimeters_to_meters(cm)
    (cm / 100000.0).round(2)
  end
end
