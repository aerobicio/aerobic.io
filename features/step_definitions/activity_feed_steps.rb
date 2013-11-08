Given(/^"(.*?)" is a member$/) do |name|
  Capybara.session_name = name
  create_registered_account(name)
  Capybara.session_name = "mine"
end

Then(/^I should see the workout in my activity feed$/) do
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
end

Then(/^"(.*?)" should see the workout in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
  Capybara.session_name = "mine"
end

Then(/^"(.*?)" should not see the workout in their activity feed$/) do |name|
  Capybara.session_name = name
  visit dashboard_path
  page.should have_no_content "Distance: 41.32km"
  Capybara.session_name = "mine"
end
