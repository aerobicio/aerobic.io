Feature: Profile page
  In order to see my own activity
  As a registered member
  I should have a profile page

  @activity
  Scenario: Viewing my activity
    Given I am a member
    And I have some activity
    When I visit my profile page
    Then I should see my own activity
