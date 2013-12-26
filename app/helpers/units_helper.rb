# UnitsHelper provides standard ways of converting data from base units into
# common formatting for presentation to users
module UnitsHelper
  def format_duration(duration_ms)
    I18n.t("units.duration", duration: (duration_ms / 1000 / 60))
  end

  def format_distance(distance_cm)
    I18n.t("units.distance", distance: (distance_cm / 100000.0).round(2))
  end
end
