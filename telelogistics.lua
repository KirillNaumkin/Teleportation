require "util"
require "config"

--[[Global variables hierarchy in this mod:
  global = {
    Telelogistics = {
      telesendings = {}, array of {
        sender = beacon.key; contains a key of a beacon-sender
        receiver = beacon.key; contains a key of a beacon-receiver
        key = sender .. ">" .. receiver; it's an id for using in gui elements representing this sending
        distance; number; the distance between sender and receiver, for calculating energy consumption
        filters; dictionary; if nil, no items will be sent
      }
    }
  }
    Telelogistics = {}; dictionary
      telesendings = {}; list
        sender = beacon.key; contains a key of a beacon-sender
        receiver = beacon.key; contains a key of a beacon-receiver
        key = sender .. ">" .. receiver; it's an id for using in gui elements representing this sending
        distance; number; the distance between sender and receiver, for calculating energy consumption
        filters; dictionary; if nil, no items will be sent
    tick_of_last_check; number of tick when the last periodical check has been performed
  Telelogistics = {}; dictionary
    config = {}; dictionary
      [contents of Telelogistics.config see in config.lua] - not implemented yet
]]


--===================================================================--
--########################## EVENT HANDLERS #########################--
--===================================================================--

function Telelogistics.Ticker()
  --
end

--===================================================================--
--############################ FUNCTIONS ############################--
--===================================================================--
