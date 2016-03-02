@use_db
Feature: Deleting Archives

  Background:
    Given an Archive exists
    And the User visits '/archives'

  @javascript
  Scenario: Delete a single Archive
    When the User clicks on the 'Delete' button of the first Archive and accepts the confirmation
    Then the Archive should get deleted

  @javascript
  Scenario: Abort deletion of a single Archive
    When the User clicks on the 'Delete' button of the first Archive and dismisses the confirmation
    Then the Archive should be kept
