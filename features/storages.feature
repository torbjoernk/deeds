Feature: Storages

  Background:
    Given a Storage exists
    And the User visits '/storages'

  Scenario: Index table
    Then the User should see a table with storages

  @javascript
  Scenario: Creating a new Storage
    When the User clicks on the "New Storage" button
    And enters the new Storage's title
    And clicks on "Create Storage"
    Then a new Storage with given title should be created

  @javascript
  Scenario: Show details of a single Storage
    And the User clicks on the "Show" button of the first Storage
    Then the User should see the Storage's details

  @javascript
  Scenario: Edit details of a single Storage
    When the User clicks on the "Edit" button of the first Storage
    And changes the Storage's title
    And clicks on "Update Storage"
    Then the Storage's title should be changed to the new value

  @javascript
  Scenario: Delete a single Storage
    When the User clicks on the 'Delete' button of the first Storage and accepts the confirmation
    Then the Storage should get deleted

  @javascript
  Scenario: Abort deletion of a single Storage
    When the User clicks on the 'Delete' button of the first Storage and dismisses the confirmation
    Then the Storage should be kept
