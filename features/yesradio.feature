Feature: Call Yes.com API using Ruby
  In order to retrieve Yes.com data in Ruby code
  programmers
  want a Ruby interface to Yes.com API

  Scenario: List Stations
    Given nothing
    When I look for 10 stations called "KEXP"
    Then I should see a radio with name "KEXP" and market "Seattle - Tacoma, WA"

  Scenario: List Stations Empty
    Given nothing
    When I look for 10 stations called "ABCDEFGH"
    Then I should see nothing
