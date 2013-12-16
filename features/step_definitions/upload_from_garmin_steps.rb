When(/^I add a workout using a FIT file$/) do
  add_workout_using_fit_file
end

When(/^I add a workout using a TCX file$/) do
  add_workout_using_tcx_file
end

Then(/^I should see workout information on my dashboard$/) do
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
end
