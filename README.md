# YesRadio #

Ruby gem to access Yes.com API

<a name="rubygem_install" />
## Installation ##

    sudo gem install yesradio -s http://gems.github.com

## Examples ##

### To show a list of 'Rock' stations ###

    require 'yesradio'
    query = Yesradio::StationsSearchCriteria.new
    query.match = "KWOF"
    result = Yesradio::search_stations query  

### To show details of 'WFNX' radio ###

    require 'yesradio'
    Yesradio::match_station "WFNX"
