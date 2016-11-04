--[[Defines how many teleporter beacons should be on page. NOT ZERO VALUE!
    Default is 10. ]]
Teleportation.config.page_size = 20

--[[Defines what should be shown in pager.
    • "true" for pages (e.g. "2/4");
    • "false" for beacons count (e.g. "11-20/37", if page_size is 10).
    Default is "true". ]]
--Teleportation.config.show_page_numbers = true; TODO. Not yet implemented. I'm lazy))) But should I? Maybe it's quite useless?

--[[Defines whether all players can use all beacons in spite of force membership or not.
    • "true" members of opposing force can use your beacons;
    • "false" all beacons are common only inside one force.
    Default is "false". ]]
Teleportation.config.all_beacons_for_all = false

--[[Defines whether straight jumping ignores collisions (buildings, trees, water, biters) or not.
    • "true" is for ignoring all collisions - you can jump on water or building but cannot walk there;
    • "false" is for normal behaviour of collisions checks.
    Default is "false". ]]
Teleportation.config.straight_jump_ignores_collisions = false

--[[Defines how much energy should be in Personal Teleporter equipment to use Targeter for straight jump. NOT ZERO VALUE!
    Note: Personal Teleporter stats are: buffer = 100MJ, charge rate = 500kW.
    Default is 250000 (250kJ/m). ]]
Teleportation.config.energy_in_equipment_to_use_portal = 250000

--[[Defines how much energy should be in Personal Teleporter equipment to jump to Teleporter Beacon. NOT ZERO VALUE!
    Note: Personal Teleporter stats are: buffer = 100MJ, charge rate = 500kW.
    Default is 50000000 (50MJ). ]]
Teleportation.config.energy_in_equipment_to_use_beacon = 50000000

--[[Defines how much energy should be in Teleporter Beacon to accept it's activation. NOT ZERO VALUE!
    Note: Teleporter Beacon stats are: buffer = 300MJ, charge rate = 5MW.
    Default is 100000000 (100MJ). ]]
Teleportation.config.energy_in_beacon_to_activate = 100000000
