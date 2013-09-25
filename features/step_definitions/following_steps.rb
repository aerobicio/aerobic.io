Given(/^another member follows me$/) do
  register_another_member
  $switch_board.activate_following
  visit members_path
  click_button "Follow"
  @another_member_who_follows_me = @identity
  $switch_board.deactivate_following
end

Given(/^the following feature is off$/) do
  $switch_board.deactivate_following
end

Given(/^I am following another member$/) do
  # This step is kinda pointless but left in for later usage and feature
  # completeness.
end

Then(/^I should not be able to unfollow them$/) do
  visit members_path
  page.should have_content("The page you were looking for doesn't exist")
end

Given(/^I am not following another member$/) do
  register_another_member
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
  visit members_path
  click_button "Follow"
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
