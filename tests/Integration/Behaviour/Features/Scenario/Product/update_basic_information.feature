# ./vendor/bin/behat -c tests/Integration/Behaviour/behat.yml -s product --tags update-basic-information
@reset-database-before-feature
Feature: Update product basic information from Back Office (BO)
  As a BO user
  I need to be able to update product basic information from BO

  @update-basic-information
  Scenario: I update product basic information
    Given I add product "product1" with following basic information:
      | name       | en-US:funny mug      |
      | is_virtual | false                |
    And product "product1" type should be standard
    And product "product1" localized "name" should be "en-US:funny mug"
    When I update product "product1" basic information with following values:
      | name       | en-US:photo of funny mug |
      | is_virtual | true                     |
    Then product "product1" type should be virtual
    And product "product1" localized "name" should be "en-US:photo of funny mug"

  @update-basic-information
  Scenario: I update product basic information providing invalid product name
    Given product "product1" localized "name" is "en-US:photo of funny mug"
    When I update product "product1" basic information with following values:
      | name       | en-US:#hashtagmug        |
    Then I should get error that product name is invalid
    And product "product1" localized "name" should be "en-US:photo of funny mug"

  @update-basic-information
  Scenario: I only change product virtual property and leave other properties unchanged
    Given product "product1" localized "name" is "en-US:photo of funny mug"
    When I update product "product1" basic information with following values:
      | is_virtual       | false        |
    Then product "product1" type should be standard
    And product "product1" localized "name" should be "en-US:photo of funny mug"
