Feature: Archives

  Background:
    Given an Archive exists
    And the User visits '/archives'

  Scenario: Index table
    Then the User should see a table with archives

  @javascript
  Scenario: Creating a new Archive
    When the User clicks on the "New Archive" button
    And enters the new Archive's title
    And clicks on "Create Archive"
    Then a new Archive with given title should be created

  @javascript
  Scenario: Show details of a single Archive
    And the User clicks on the "Show" button of the first Archive
    Then the User should see the Archives's details

  @javascript
  Scenario: Edit details of a single Archive
    When the User clicks on the "Edit" button of the first Archive
    And changes the Archive's title
    And clicks on "Update Archive"
    Then the Archive's title should be changed to the new value

  @javascript
  Scenario: Delete a single Archive
    When the User clicks on the 'Delete' button of the first Archive and accepts the confirmation
    Then the Archive should get deleted

  @javascript
  Scenario: Abort deletion of a single Archive
    When the User clicks on the 'Delete' button of the first Archive and dismisses the confirmation
    Then the Archive should be kept
