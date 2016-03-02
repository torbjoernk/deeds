@use_db
Feature: Editing Archives

  Background:
    Given an Archive exists
    And the User visits '/archives'

  @javascript
  Scenario: Edit details of a single Archive
    When the User clicks on the 'Edit' button of the first Archive
    When the User changes the Archive's title
    And clicks on "Update Archive"
    Then the Archive's title should be changed to the new value
