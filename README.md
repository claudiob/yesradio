Ruby gem to access Yes.com API

# Examples 

- To show a list of 'Rock' stations

    require 'yesradio'
    query = Yesradio::StationsSearchCriteria.new
    query.match = "Rock"
    result = Yesradio::search_stations query  

- To show details of 'WFNX' radio

    require 'yesradio'
    Yesradio::match_station "WFNX"
