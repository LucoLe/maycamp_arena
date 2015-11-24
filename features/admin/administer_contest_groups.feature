@admin @contest_groups
Feature: Administer contest groups
  In order to be able to control the system
  As a administrator
  I want to be able to administer the contest groups

  Background:
    Given there is an admin user with attributes:
      | login                 | valo                      |
      | name                  | Valentin Mihov            |
      | email                 | valentin.mihov@gmail.com  |
      | unencrypted_password  | secret                    |
    And I am not logged in
    And I am on the login page
    And I fill in the following:
      | login                 | valo                      |
      | password              | secret                    |
    And I press "Влез"

  Scenario: Create new contest group
    Given I am on the contest group list in the admin panel
    And I follow "Новa група"
    And I fill in the following:
      | Име: | Test |
    And I press "Създаване"
    Then I should be on the contest group list in the admin panel
    And I should see "Test"

  Scenario: Delete a contest group
    Given I am on the contest group list in the admin panel
    And I follow "Новa група"
    And I fill in the following:
      | Име: | Test |
    And I press "Създаване"
    And I follow "Изтриване"
    Then I should be on the contest group list in the admin panel
    And I should not see "Test"

  Scenario: Edit a contest group
    Given I am on the contest group list in the admin panel
    And I follow "Новa група"
    And I fill in the following:
      | Име: | Test |
    And I press "Създаване"
    And I follow "Промяна"
    And I fill in the following:
      | Име: | Others |
    And I press "Обновяване"
    Then I should be on the contest group list in the admin panel
    And I should see "Групата е обновена успешно."

  Scenario: Edit a contest group and go to the index page
    Given I am on the contest group list in the admin panel
    And I follow "Новa група"
    And I fill in the following:
      | Име: | Test |
    And I press "Създаване"
    And I follow "Промяна"
    And I fill in the following:
      | Име: | Others |
    And I follow "Отказ"
    Then I should be on the contest group list in the admin panel
    And I should see "Test"
