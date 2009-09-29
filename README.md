# YesRadio #

Ruby gem to access Yes.com API

## Installation ##

    sudo gem install claudiob-yesradio -s http://gems.github.com

## Documentation ##

http://rdoc.info/projects/claudiob/yesradio

## Examples ##

### To show a list of 'Rock' stations ###

    require 'yesradio'
    Yesradio::search_stations :match => "Rock"

### To show details of 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_station :name => "WFNX"

### To show log of tracks played on 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_log :name => "WFNX"

### To show recent tracks played on 'WFNX' radio ###

    require 'yesradio'
    Yesradio::get_recent :name => "WFNX"

### To show a chart of popular Rock songs ###

    require 'yesradio'
    Yesradio::get_chart :genre => "Rock"

### To show a list of songs by artist Rihanna ###

    require 'yesradio'
    Yesradio::get_media :aid => 610471

### To show a list of songs related to Umbrella (Rihanna) ###

    require 'yesradio'
    Yesradio::get_related :mid => 11586843


## History ##

v0.1.3  2009/09/29
        Fixed wrong example in README

v0.1.2  2009/09/17
        Changed REXML with Nokogiri for XML parsing

v0.1.1  2009/09/15
        Fixed bug that made gem unusable (required inexistent file)

v0.1.0  2009/09/15
        First release with all the actions and documentation on rdoc.info

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
