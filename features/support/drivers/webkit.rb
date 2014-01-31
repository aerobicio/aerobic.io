require_relative './warning_suppressor'

Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app, stderr: WarningSuppressor)
end
