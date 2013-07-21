Feature: Sign Up
  In order to get an account
  As a new user
  I want to be able to sign up

  Scenario: Sign up using a white listed email
    Given I have a white listed email address
    When I sign up
    Then I should be signed in

  Scenario: Sign up using a non white listed email
    Given I have a non white listed email address
    When I sign up
    Then I should be told I am not on the beta list
