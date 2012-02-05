@whatson @whatson_categories
Feature: Whatson Post Categories
  Whatson posts can be assigned categories
  
  Background:
    Given I am a logged in refinery user
    Given there is a category titled "Videos"
  
  Scenario: The whatson post new/edit form has category_list
    When I am on the new whatson post form
    Then I should see "Tags"
    Then I should see "Videos"
    
  Scenario: The whatson post new/edit form saves categories
    When I am on the new whatson post form
    And I fill in "Title" with "This is my whatson post"
    And I fill in "whatson_post_body" with "And I love it"
    And I check "Videos"
    And I press "Save"

    Then there should be 1 whatson post
    And the whatson post should have 1 category
    And the whatson post should have the category "Videos"