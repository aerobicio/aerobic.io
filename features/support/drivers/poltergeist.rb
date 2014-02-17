require 'capybara/poltergeist'
require_relative './warning_suppressor'

module Capybara::Poltergeist
  class Client
    private
    def redirect_stdout
      prev = STDOUT.dup
      prev.autoclose = false
      $stdout = @write_io
      STDOUT.reopen(@write_io)

      prev = STDERR.dup
      prev.autoclose = false
      $stderr = @write_io
      STDERR.reopen(@write_io)
      yield
    ensure
      STDOUT.reopen(prev)
      $stdout = STDOUT
      STDERR.reopen(prev)
      $stderr = STDERR
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
                                    window_size: [1024, 768],
                                    phantomjs_logger: WarningSuppressor,
                                    extensions: [
                                      'vendor/assets/components/es5-shim/es5-shim.js',
                                    ]
  )
end
