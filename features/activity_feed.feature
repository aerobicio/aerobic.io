Feature: Activity Feed
  In order to see what people are doing
  As a member
  I want to be able to view a feed of all members activity

  Background:
    Given I am a member
    And "Gus" is a member
    And "Justin" is following me

  @following @activity
  Scenario: Viewing my workouts
    When I add a workout using a FIT file
    Then I should see the workout in my activity feed
    And "Justin" should see the workout in their activity feed
    And "Gus" should not see the workout in their activity feed
