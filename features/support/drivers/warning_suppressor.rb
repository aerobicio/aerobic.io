class WarningSuppressor
  IGNORES = [
    /QFont::setPixelSize: Pixel size <= 0/,
    /CoreText performance note:/,
    /Method userSpaceScaleFactor in class NSView/,
    /webkit_server/,
    /objc[81574]: Class/,
  ]

  class << self
    def write(message)
      puts(message) unless should_suppress_message?(message)
      0
    end

    private

    def should_suppress_message?(message)
      IGNORES.any? {|re| message =~ re }
    end
  end
end
