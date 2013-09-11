Then(/^I should see the workout in my activity feed$/) do
  visit dashboard_path
  page.should have_content "Distance: 41.32km"
end

When(/^another member adds a workout$/) do
  sign_out
  @original_identity = @identity
  create_registered_account
  sign_in
  add_workout
  visit dashboard_path
  sign_out
  @identity = @original_identity
  sign_in
end
