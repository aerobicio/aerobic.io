Feature: Activity Feed
  In order to see what people are doing
  As a member
  I want to be able to view a feed of all members activity

  Scenario: Viewing my workouts
    Given I am a member
    When I add a workout
    Then I should see the workout in my activity feed

  Scenario: Viewing another members workouts
    Given I am a member
    When another member adds a workout
    Then I should see the workout in my activity feed

  @following @activity @wip
  Scenario: A member should not see activies of other members they do not follow
    Given I am not following another member
    When they add a workout
    Then I should not see it in my activity feed

  @following @activity @wip
  Scenario: A member should see activities of other members they follow
    Given I am following another member
    When they add a workout
    Then I should see it in my activity feed

