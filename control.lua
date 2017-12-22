require("util")
require("config")
require("control-teleportation")
require("control-telelogistics")

--===================================================================--
--########################## EVENT HANDLERS #########################--
--===================================================================--
--First using
script.on_init(function(event)
  for i, force in pairs(game.forces) do
    force.reset_technologies()
    force.reset_recipes()
  end
end)

--Migrations
script.on_configuration_changed(Teleportation_Migrate)

--When beacon get placed by entity of any force, all players of this force should get their GUI updated.
--When teleprovider get placed, it should be remembered.
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, function(event) 
  if event.created_entity.name == "teleportation-beacon" then
    Teleportation_RememberBeacon(event.created_entity)
  elseif event.created_entity.name == "teleportation-teleprovider" then
    Telelogistics_RememberProvider(event.created_entity)
  elseif event.created_entity.name == "teleportation-portal" then
    local player = event.created_entity.last_user
    player.cursor_stack.set_stack({name = "teleportation-portal", count = 1})
    event.created_entity.destroy()
  elseif event.created_entity.name == "entity-ghost" then
    if event.created_entity.ghost_name == "teleportation-portal" then
      event.created_entity.destroy()
    end
  end
end)

--When beacon, belonging to some force, get removed, all players of this force should get their GUI updated.
script.on_event({defines.events.on_pre_player_mined_item, defines.events.on_robot_pre_mined, defines.events.on_entity_died}, function(event)
  local entity = event.entity
  if event.entity.name == "teleportation-beacon" then
    Teleportation_ForgetBeacon(entity)
  elseif event.entity.name == "teleportation-teleprovider" then
    Telelogistics_ForgetProvider(entity)
  end
end)

--When new player get created in game: new game for single player or new player connected to multiplayer game, or player joined the game -
--we should update his GUI. So if his force owns beacons - he'll see them.
script.on_event({defines.events.on_player_created, defines.events.on_player_joined_game}, function(event)
  local player = game.players[event.player_index]
  Teleportation_UpdateGui(player.force)
end)

--When forces get merged, all beacons which belong to both forces should become common (should belong to the resulting force).
script.on_event(defines.events.on_forces_merging, function(event) 
  local force_to_destroy = event.source
  local force_to_reassign_to = event.destination
  Teleportation_UpdateGui(force_to_reassign_to)
end)

--When player points on the ground while holding anything in his hand
script.on_event(defines.events.on_put_item, function(event)
	local player = game.players[event.player_index]
  --player.print("Putting item " .. game.tick)
  local destination = event.position
  Teleportation_ActivatePortal(player, destination)
end)

--Err... I don't like any tickers... 
script.on_event(defines.events.on_tick, function(event)
	if not global.tick_of_last_check then
    global.tick_of_last_check = event.tick
  end
  if event.tick - global.tick_of_last_check >= 30 then
    global.tick_of_last_check = event.tick
    Teleportation_EnergyProgressUpdate()
    Teleportation_RemindSelectedBeacons()
  end
  Telelogistics_ProcessProvidersQueue()
end)

--When player get clicked the button - something should happen =).
script.on_event(defines.events.on_gui_click, function(event)
  if not string.find(event.element.name, "teleportation_") then
    return
  end
  Teleportation_ProcessGuiClick(event.element)
  if event.element and event.element.valid then
    Telelogistics_ProcessGuiClick(event.element)
  end
end)

--===================================================================--
--############################ FUNCTIONS ############################--
--===================================================================--

