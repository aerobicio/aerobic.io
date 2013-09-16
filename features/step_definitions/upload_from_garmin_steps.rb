When(/^I upload a FIT file from a device$/) do
  visit upload_path

  # This is a hack that hits the upload controller directly as I have no idea
  # how to do this from the user interface without having a Garmin permentantly
  # connected to the computer.
  page.driver.post upload_path, activity: fit_file, format: :json
end

Then(/^I should see workout information on my dashboard$/) do
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
end
