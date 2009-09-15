# YesRadio #

Ruby gem to access Yes.com API

<a name="rubygem_install" />
## Installation ##

    sudo gem install claudiob-yesradio -s http://gems.github.com

## Examples ##

### To show a list of 'Rock' stations ###

    require 'yesradio'
    query = Yesradio::StationsSearchCriteria.new
    query.match = "KWOF"
    result = Yesradio::search_stations query  

### To show details of 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_station "WFNX"

### To show log of tracks played on 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_log "WFNX"

### To show recent tracks played on 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_recent "WFNX"


## History ##

v0.0.2  2009/09/15
        Added support for actions: chart, media, related.
        Added documentation through RDoc.
        Added cucumber features for listing stations.

v0.0.1  2009/09/15
        Added support for actions: log, recent.

v0.0.0  2009/09/14
        Added support for actions: station, stations

## Copyright ##

Copyright (c) 2009 Claudio Baccigalupo. See LICENSE for details.
