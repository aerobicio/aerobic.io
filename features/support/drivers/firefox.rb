Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  # profile keys map to settings in 'about:config'
  profile['javascript.options.strict']         = true
  profile['extensions.update.enabled']         = false
  profile['app.update.enabled']                = false
  profile['app.update.auto']                   = false
  profile['network.http.prompt-temp-redirect'] = false
  profile['plugin.state.flash']                = 0
  profile['plugin.state.garmingpscontrol']     = 0
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end
Capybara.javascript_driver = :firefox
