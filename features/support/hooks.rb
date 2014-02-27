Around('@fast') do |scenario, block|
  Timeout.timeout(0.5) do
    block.call
  end
end

Before('@poltergeist') do
  Capybara.current_driver = :poltergeist
end

Before('@firefox') do
  Capybara.current_driver = :firefox
end

After('@poltergeist, @firefox') do
  Capybara.use_default_driver
end

Before('@no-garmin') do
  ENV['DISABLE_GARMIN_TESTMODE'] = 'true'
end

After('@no-garmin') do
  ENV['DISABLE_GARMIN_TESTMODE'] = nil
end
