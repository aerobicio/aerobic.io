Given(/^I have added a workout$/) do
  add_workout
end

When(/^I visit the workout page from the activity feed$/) do
  visit dashboard_path

  within "#activity" do
    page_has_workout
    click_link(I18n.t("activity.workout.title.first_person"))
  end
end

Then(/^I should see my workout$/) do
  page_has_workout
end
