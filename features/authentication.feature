Feature: Authentication
  In order to use my account
  As a registered user
  I want to be able to sign in and out

  Scenario: Signing in using an email/password
    Given I have a registered account
    When I sign in with valid credentials
    Then I should be signed in
    And I should be on the "dashboard_path" route

  Scenario: Singing in fails using an email/password
    Given I have a registered account
    When I sign in with invalid credentials
    Then I should not be signed in
    And I should be on the "sign_in_path" route

  Scenario: Signing out
    Given I am signed in
    When I sign out
    Then I should not be signed in
    And I should be on the "root_path" route
