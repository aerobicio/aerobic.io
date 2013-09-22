Given(/^the following feature is off$/) do
  $switch_board.deactivate_following
end

Given(/^I am following another member$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not be able to unfollow them$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am not following another member$/) do
  sign_out
  @original_identity = @identity
  create_registered_account
  sign_in
  sign_out
  @identity = @original_identity
  sign_in
end

Then(/^I should not be able to follow them$/) do
  visit members_path
  page.should have_content("The page you were looking for doesn't exist")
end

Given(/^the following feature is on$/) do
  $switch_board.activate_following
end

When(/^I follow another member$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see that fact in my activity feed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the member I followed should see that fact in their activity feed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^members who follow me should see that fact in their activity feed$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I unfollow another member$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the member I unfollowed should not see that fact in their activity feed$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^members who follow me should not see that fact in their activity feed$/) do
  pending # express the regexp above with the code you wish you had
end
