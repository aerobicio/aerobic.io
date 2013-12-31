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
  binding.pry
  page.should have_content "We couldn't find any devices!"
end
