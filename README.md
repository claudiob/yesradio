Ruby gem to access Yes.com API

# Examples 

- To show a list of 'Rock' stations
    <pre><code>
    require 'yesradio'
    query = Yesradio::StationsSearchCriteria.new
    query.match = "KWOF"
    result = Yesradio::search_stations query  
    </code></pre>

- To show details of 'WFNX' radio

    <pre><code>
    require 'yesradio'
    Yesradio::match_station "WFNX"
    </code></pre>
