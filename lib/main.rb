#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================

require 'yesradio'

# get the list of radio stations
query = Yesradio::StationsSearchCriteria.new
query.match = "KWOF"
stations = Yesradio::search_stations query  
p stations

# get the details of a radio station
Yesradio::match_station "WFNX"

# get the log of songs played on a radio
Yesradio::get_log "KEXP"

# get the recent songs played on a radio
Yesradio::get_recent "KEXP"
