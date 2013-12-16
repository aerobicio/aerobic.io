Given(/^"(.*?)" is a member$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  Capybara.session_name = "mine"
end

Given(/^I have some activity$/) do
  add_workout_using_fit_file
end

Then(/^I should see the workout in my activity feed$/) do
  visit dashboard_path
  page_has_workout
end

Then(/^"(.*?)" should see the workout in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page_has_workout
  Capybara.session_name = "mine"
end

Then(/^"(.*?)" should not see the workout in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page_doesnt_have_workout
  Capybara.session_name = "mine"
end

def page_has_workout
  page.should have_content "Distance: 41.32km"
end

def page_doesnt_have_workout
  page.should have_no_content "Distance: 41.32km"
end
