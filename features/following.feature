Feature: Following
  In order to see what my friends are doing
  As a member
  I want to be able to follow other members

  Background:
    Given I am a member
    And "Justin" is following me

  @following
  Scenario: A member can follow another member when the feature is on
    Given I follow "Gus"
    Then I should see that fact in my activity feed
    And "Gus" should see that I followed them in their activity feed
    And "Justin" should see that I followed "Gus" in their activity feed

  @following
  Scenario: A member can unfollow another member when the feature is on
    Given I follow "Gus"
    When I unfollow "Gus"
    Then I should see that I unfollowed "Gus" in my activity feed
    And "Gus" should not see that fact in their activity feed
    And "Justin" should not see that fact in their activity feed
