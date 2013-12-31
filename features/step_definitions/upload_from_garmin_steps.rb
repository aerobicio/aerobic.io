When(/^I visit the upload page$/) do
  visit upload_path
end

When(/^I add a workout$/) do
  add_workout
end

Then(/^I should see workout information on my dashboard$/) do
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
end

Then(/^I should see a message telling me that I have no devices$/) do
  page.should have_content "Uh oh, we couldn’t find any devices!"
end
