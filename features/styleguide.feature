Feature: Styleguide
  In order to keep our CSS from becoming unweildy
  As a developer
  I want to be able to be able to view the styleguide
  Given I have documented my CSS

  Scenario: "Viewing the styleguide"
    Then I should be able to browse rule classifications in the styleguide

  Scenario: "Viewing specific component examples"
    Then I should be able to view an example for each component
