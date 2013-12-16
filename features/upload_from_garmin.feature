Feature: Upload From Garmin
  In order to track my workouts
  As a registered member
  I want to be able to upload files from my Garmin

  Scenario: Uploading a FIT file from a device
    Given I am a member
    When I add a workout using a FIT file
    Then I should see the workout in my activity feed

  @wip
  Scenario: Uploading a TCX file from a device
    Given I am a member
    When I add a workout using a TCX file
    Then I should see the workout in my activity feed
