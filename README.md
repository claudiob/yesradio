# YesRadio #

Ruby gem to access Yes.com API

## Installation ##

    gem sources -a http://gems.github.com
    sudo gem install yesradio

## Examples ##

- To show a list of 'Rock' stations

    require 'yesradio'
    query = Yesradio::StationsSearchCriteria.new
    query.match = "KWOF"
    result = Yesradio::search_stations query  

- To show details of 'WFNX' radio

    require 'yesradio'
    Yesradio::match_station "WFNX"
