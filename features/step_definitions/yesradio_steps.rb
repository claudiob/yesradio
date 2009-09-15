Given /^nothing$/ do
  
end

When /^I look for ([0-9]+) stations called "([^\"]*)"$/ do |max, match|
  @stations = Yesradio::search_stations :match => match, :max => max
end

Then /^I should see a radio with name "([^\"]*)" and market "([^\"]*)"$/ do |name, market|
  @stations.collect do |station| 
    station.name == name && station.market == market
  end.inject{ |sum, el| sum || el }.should be_true
end

Then /^I should see nothing$/ do
  @stations.should be_nil
end
