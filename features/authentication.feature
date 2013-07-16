Feature: Authentication
  In order to use my account
  As a registered user
  I want to be able to log in and out

  @wip
  Scenario: Login using an email/password
    Given I have a registered account
    When I log in with valid credentials
    Then I should be logged in

  @wip
  Scenario: Login fails using an email/password
    Given I have a registered account
    When I log in with invalid credentials
    Then I should not be logged in

  @wip
  Scenario: Logout
    Given I am logged in
    When I log out
    Then I should not be logged in
