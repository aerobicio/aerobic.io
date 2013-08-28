@flip @sign_up
Feature: Sign Up
  In order to get an account
  As a new user
  I want to be able to sign up

  Scenario: Signing up
    Given the sign up feature is active
    When I sign up with valid credentials
    Then I should be signed in

  Scenario: Signing up using invalid credentials
    Given the sign up feature is active
    When I sign up with invalid credentials
    Then I should be on the sign up page
    And I should see error messages

  Scenario: Signing up when
    Given the sign up feature is not active
    When I visit the sign up page
    Then I should be redirected to the sign in page
    And I should not see the sign up link
    
