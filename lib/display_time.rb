# Class for converting a duration in seconds into Hour/Minute/Second components.
#
class DisplayTime
  def initialize(duration)
    @duration = duration
  end

  def hours
    @hours || hours_from_duration
  end

  def minutes
    @minutes || minutes_from_duration
  end

  def seconds
    @seconds || seconds_from_duration
  end

  private

  def hours_from_duration
    @duration / (60 * 60)
  end

  def minutes_from_duration
    (@duration - hours_in_seconds) / 60
  end

  def seconds_from_duration
    @duration - hours_in_seconds - minutes_in_seconds
  end

  def minutes_in_seconds
    self.minutes.to_i * 60
  end

  def hours_in_seconds
    self.hours.to_i * 60 * 60
  end
end
