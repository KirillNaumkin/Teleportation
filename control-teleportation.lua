require("config")
require("control-common")

--[[Global variables hierarchy in this mod:
  global
    Teleportation = {}; dictionary
      beacons = {}; list
        entity = LuaEntity; contains such fields as built_by (last_user since 0.14.6), position, surface, force and so on - needed to teleport and to operate with players gui
        energy_interface = LuaEntity; contains hidden accumulator to store beacon's energy;
        marker = LuaCustomChartTag; contains marker to show beacon's name on map;
        key = entity.surface.name .. "-" .. entity.position.x .. "-" .. entity.position.y; it's an id for gui elements representing this beacon
        name = "x:" .. entity.position.x .. ",y:" .. entity.position.y .. ",s:" .. entity.surface.name; it's default name to show in gui element
      player_settings = {}; dictionary, e.g. global.Teleportation.player_settings[player_name].used_portal_on_tick
        used_portal_on_tick; number
        beacons_list_is_sorted_by; number: 1 is global list as is (default), 2 is sorting by distance from start, 3 is sorting by distance from player, 4 is sorting by alphabet
        beacons_list_current_page_num; number, default is 1
    tick_of_last_check; number of tick when the last periodical check has been performed
  Teleportation = {}; dictionary
    config = {}; dictionary
      contents of Teleportation.config see in config.lua
]]

--===================================================================--
--########################## EVENT HANDLERS #########################--
--===================================================================--

script.on_event("teleportation-hotkey-main-window", function(event)
  local player_index = event.player_index
  Teleportation_SwitchMainWindow(game.players[player_index])
end)

script.on_event("teleportation-hotkey-activate-closest-beacon", function(event)
  local player_index = event.player_index
  Teleportation_ActivateNearestBeacon(game.players[player_index])
end)

--===================================================================--
--############################ FUNCTIONS ############################--
--===================================================================--

--Ensures that globals were initialized.
function Teleportation_InitializeGeneralGlobals()
  if not global.Teleportation then
    global.Teleportation = {}
  end
  if not global.Teleportation.beacons then
    global.Teleportation.beacons = {}
  end
end

--Ensures that globals were initialized.
function Teleportation_InitializePlayerGlobals(player)
  Teleportation_InitializeGeneralGlobals()
  if not global.Teleportation.player_settings then
    global.Teleportation.player_settings = {}
  end
  if not global.Teleportation.player_settings[player.name] then
    global.Teleportation.player_settings[player.name] = {}
    global.Teleportation.player_settings[player.name].used_portal_on_tick = 1
    global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by = 1
    global.Teleportation.player_settings[player.name].beacons_list_current_page_num = 1
  end
end

--Adds new beacon to global list and calls GUI update for all members of the force.
function Teleportation_RememberBeacon(entity)
  Teleportation_InitializeGeneralGlobals()
  entity.operable = false
  entity.active = false
  local beacon = {}
  beacon.key = Common_CreateEntityKey(entity)
  beacon.name = Common_CreateEntityName(entity)
  beacon.entity = entity
  local energy_interface = entity.surface.create_entity({name = "teleportation-beacon-electric-energy-interface", position = entity.position, force = entity.force.name})
  energy_interface.minable = false
  energy_interface.destructible = false
  beacon.energy_interface = energy_interface
	local chart_tag = {
		icon = {type = "item", name = "teleportation-portal"},
		position = entity.position,
		text = beacon.name,
		last_user = entity.last_user,
		target = beacon.entity
	}
  local marker = entity.force.add_chart_tag(beacon.entity.surface, chart_tag)
  beacon.marker = marker
  table.insert(global.Teleportation.beacons, beacon)
  Teleportation_UpdateGui(beacon.entity.force)
end

--Removes specified beacon from global list and calls GUI update.
function Teleportation_ForgetBeacon(entity)
  local key_to_forget = Common_CreateEntityKey(entity)
  for i = #global.Teleportation.beacons, 1, -1 do
    local beacon = global.Teleportation.beacons[i]
    if beacon.key == key_to_forget then
      if global.Teleportation.beacons[i].energy_interface and global.Teleportation.beacons[i].energy_interface.valid then
        global.Teleportation.beacons[i].energy_interface.destroy()
      end
      if global.Teleportation.beacons[i].marker and global.Teleportation.beacons[i].marker.valid then
        global.Teleportation.beacons[i].marker.destroy()
      end
      table.remove(global.Teleportation.beacons, i)
      Teleportation_UpdateGui(entity.force)
      return
    end
  end
end

--Counts either all beacons or those which belong to the specified force.
function Teleportation_CountBeacons(force_name)
  local count = 0
  if force_name == nil then
    count = #global.Teleportation.beacons
  else
    for i, beacon in pairs(global.Teleportation.beacons) do
      if beacon.entity.force.name == force_name then
        count = count + 1
      end
    end
  end
  return count
end

--Reminds beacons' names for selected beacons
function Teleportation_RemindSelectedBeacons()
  for i, player in pairs(game.players) do
    if Common_IsPlayerOk(player) and Common_IsEntityOk(player.selected) and player.selected.name == "teleportation-beacon" then
      local beacon = Common_GetBeaconByKey(Common_CreateEntityKey(player.selected))
      Teleportation_ShowBeaconReminder(beacon, player)
    else
      Teleportation_CloseBeaconReminder(player)
    end
  end
end

--Swaps the beacon with the specified key with the previous in the global list. Affects to all members of the specified force.
function Teleportation_ReorderBeaconUp(beacon_key, force_name, player)
  local beacon_to_swap, beacon_to_swap_index = Common_GetBeaconByKey(beacon_key)
  if beacon_to_swap_index > 1 then
    for i = beacon_to_swap_index - 1, 1, -1 do
      if global.Teleportation.beacons[i].entity.force.name == force_name or settings.global["Teleportation-all-beacons-for-all"].value then
        global.Teleportation.beacons[beacon_to_swap_index] = global.Teleportation.beacons[i]
        global.Teleportation.beacons[i] = beacon_to_swap
        return true
      end
    end
  end
  return false
end

--Swaps the beacon with the specified key with the next in the global list. Affects to all members of the specified force.
function Teleportation_ReorderBeaconDown(beacon_key, force_name, player)
  local beacon_to_swap, beacon_to_swap_index = Common_GetBeaconByKey(beacon_key)
  local beacons_count = Teleportation_CountBeacons()
  if beacon_to_swap_index ~= beacons_count then
    for i = beacon_to_swap_index + 1, beacons_count do
      if global.Teleportation.beacons[i].entity.force.name == force_name or settings.global["Teleportation-all-beacons-for-all"].value then
        global.Teleportation.beacons[beacon_to_swap_index] = global.Teleportation.beacons[i]
        global.Teleportation.beacons[i] = beacon_to_swap
        return true
      end
    end
  end
  return false
end

--Sorts beacons list and returns sorted list as copy.
--If sorting is by distance from game start, then firstly go beacons on nauvis, then others.
--If sorting is by distance from player, then firstly go beacons on player's current surface.
function Teleportation_GetBeaconsSorted(list, force_name, sort_order, player)
  local sorted_beacons = {}
  for i, beacon in pairs(list) do
    if beacon.entity and beacon.entity.valid then
      if force_name == beacon.entity.force.name or settings.global["Teleportation-all-beacons-for-all"].value then
        table.insert(sorted_beacons, beacon)
      end
    end
  end
  if sort_order == 1 then
    --Do nothing
  elseif sort_order == 2 then --sort by distance from game start
    local sorted_beacons_on_nauvis = {}
    local sorted_beacons_not_on_nauvis_by_surfaces = {}
    for i, beacon in pairs(sorted_beacons) do
      if beacon.entity.surface.name == "nauvis" then
        table.insert(sorted_beacons_on_nauvis, beacon)
      else
        local surface_name = beacon.entity.surface.name
        if not sorted_beacons_not_on_nauvis_by_surfaces[surface_name] then
          sorted_beacons_not_on_nauvis_by_surfaces[surface_name] = {}
        end
        table.insert(sorted_beacons_not_on_nauvis_by_surfaces[surface_name], beacon)
      end
    end
    table.sort(sorted_beacons_on_nauvis, function(a,b)
      local dist_a = Common_GetDistanceBetween(a.entity.position, {x = 0, y = 0})
      local dist_b = Common_GetDistanceBetween(b.entity.position, {x = 0, y = 0})
      return dist_a < dist_b
    end)
    for surface_name, beacons_on_surface in pairs(sorted_beacons_not_on_nauvis_by_surfaces) do
      table.sort(beacons_on_surface, function(a,b)
        local dist_a = Common_GetDistanceBetween(a.entity.position, {x = 0, y = 0})
        local dist_b = Common_GetDistanceBetween(b.entity.position, {x = 0, y = 0})
        return dist_a < dist_b
      end)
      for n, beacon in pairs(beacons_on_surface) do
        table.insert(sorted_beacons_on_nauvis, beacon)
      end
    end
    sorted_beacons = sorted_beacons_on_nauvis
  elseif sort_order == 3 then --sort by distance from player
    local sorted_beacons_on_current_surface = {}
    local sorted_beacons_not_on_current_surface_by_surfaces = {}
    for i, beacon in pairs(sorted_beacons) do
      if beacon.entity.surface.name == player.surface.name then
        table.insert(sorted_beacons_on_current_surface, beacon)
      else
        local surface_name = beacon.entity.surface.name
        if not sorted_beacons_not_on_current_surface_by_surfaces[surface_name] then
          sorted_beacons_not_on_current_surface_by_surfaces[surface_name] = {}
        end
        table.insert(sorted_beacons_not_on_current_surface_by_surfaces[surface_name], beacon)
      end
    end
    table.sort(sorted_beacons_on_current_surface, function(a,b)
      local dist_a = Common_GetDistanceBetween(a.entity.position, player.position)
      local dist_b = Common_GetDistanceBetween(b.entity.position, player.position)
      return dist_a < dist_b
    end)
    for surface_name, beacons_on_surface in pairs(sorted_beacons_not_on_current_surface_by_surfaces) do
      table.sort(beacons_on_surface, function(a,b)
        local dist_a = Common_GetDistanceBetween(a.entity.position, player.position)
        local dist_b = Common_GetDistanceBetween(b.entity.position, player.position)
        return dist_a < dist_b
      end)
      for n, beacon in pairs(beacons_on_surface) do
        table.insert(sorted_beacons_on_current_surface, beacon)
      end
    end
    sorted_beacons = sorted_beacons_on_current_surface
  elseif sort_order == 4 then --sort by alphabet
    local beacons = list
    table.sort(beacons, function(a,b)
      return a.name < b.name
    end)
    sorted_beacons = beacons
  end
  return sorted_beacons
end

--Returns defined page of beacons list
function Teleportation_GetListPage(player, list, page, page_size)
  local list_page = {} --page of list, consists all records of the specified page
  local current_page_num --current page naumber, usually equals to received "page" and doesn't changes
  local total_pages_num --total number of pages
  total_pages_num = math.floor(#list / page_size)
  if total_pages_num * page_size < #list then
    total_pages_num = total_pages_num + 1
  end
  if page <= total_pages_num then
    current_page_num = page
  else
    current_page_num = total_pages_num
    global.Teleportation.player_settings[player.name].beacons_list_current_page_num = current_page_num
  end
  local first_record_num_on_page = (current_page_num  - 1)* page_size + 1
  for i = first_record_num_on_page, first_record_num_on_page + page_size - 1, 1 do
    if not list[i] then
      break
    end
    table.insert(list_page, list[i])
  end
  return list_page, current_page_num, total_pages_num
end

--Tries to activate nearest beacon (on ctrl+y)
function Teleportation_ActivateNearestBeacon(player)
  if Common_IsPlayerOk(player) then
    local list = global.Teleportation.beacons
    Teleportation_InitializePlayerGlobals(player)
    local list_sorted = Teleportation_GetBeaconsSorted(list, player.force.name, 3 --[[sort by distance from player]], player)
    for i, beacon in pairs(list_sorted) do
      if Teleportation_ActivateBeacon(player, beacon.key, true) then
        return true
      end
    end
    player.print({"message-jump-to-closest-beacon-failure"})
    return false
  end
end

--Tries to activate defined beacon
function Teleportation_ActivateBeacon(player, beacon_key, silent_mode)
  local required_energy_eq = Teleportation.config.energy_in_equipment_to_use_beacon
  local required_energy_beacon = Teleportation.config.energy_in_beacon_to_activate
  local beacon = Common_GetBeaconByKey(beacon_key)
	local sending_beacon = Teleportation_GetSendingBeaconUnderPlayer(player, required_energy_beacon)
  local failure_message
  if sending_beacon then
    if sending_beacon.key == beacon_key then
      failure_message = {"message-sender-and-destination-are-same"}
      if not silent_mode then
        player.print(failure_message)
      end
      return false
    end
    if player.vehicle and player.vehicle.valid then
      failure_message = {"message-sitting-in-vehicle"}
      if not silent_mode then
        player.print(failure_message)
      end
      return false
    end
    if sending_beacon.energy_interface.energy >= required_energy_beacon then
      local receiving_beacon = beacon
      if receiving_beacon.energy_interface.energy >= required_energy_beacon then
        Teleportation_BlockProjectiles(player)
        Teleportation_Teleport(player, receiving_beacon.entity.surface.name, receiving_beacon.entity.position)
        sending_beacon.energy_interface.energy = sending_beacon.energy_interface.energy - required_energy_beacon
        receiving_beacon.energy_interface.energy = receiving_beacon.energy_interface.energy - required_energy_beacon
        return true
      else --receiving_beacon.energy_interface.energy < required_energy_beacon
        failure_message = {"message-no-power-tb", math.floor(receiving_beacon.energy_interface.energy * 100 / required_energy_beacon)}
        if not silent_mode then
          player.print(failure_message)
        end
        return false
      end
    end
  end
  local equipment_energy = Teleportation_GetPlayerEquipmentChargeLevel(player)
  if equipment_energy and equipment_energy >= 0 then
    if player.vehicle and player.vehicle.valid then
      failure_message = {"message-sitting-in-vehicle"}
      if not silent_mode then
        player.print(failure_message)
      end
      return false
    end
    if equipment_energy >= required_energy_eq then
      local receiving_beacon = beacon
      if receiving_beacon.energy_interface.energy >= required_energy_beacon then
        Teleportation_BlockProjectiles(player)
        Teleportation_Teleport(player, receiving_beacon.entity.surface.name, receiving_beacon.entity.position)
        Teleportation_DischargeEquipment(player, required_energy_eq)
        receiving_beacon.energy_interface.energy = receiving_beacon.energy_interface.energy - required_energy_beacon
        return true
      else --receiving_beacon.energy_interface.energy < required_energy_beacon
        failure_message = {"message-no-power-tb", math.floor(receiving_beacon.energy_interface.energy * 100 / required_energy_beacon)}
        if not silent_mode then
          player.print(failure_message)
        end
        return false
      end
    else --equipment_energy < required_energy_eq
      failure_message = {"message-no-power-pt", math.floor(equipment_energy * 100 / required_energy_eq)}
      player.print(failure_message)
      return false
    end
  else -- no equipment and no charged sending beacon
    failure_message = {"message-no-sending-beacons-or-equipment"}
    if not silent_mode then
      player.print(failure_message)
    end
    return false
  end
end

--Tries to jump into the position, the jump targeter targets at. (sorry for my Eng)
function Teleportation_ActivatePortal(player, destination_position)
	if Common_IsHolding({name="teleportation-portal", count=1}, player) then
    local cooldown_in_ticks_between_usages = 15
    Teleportation_InitializePlayerGlobals(player)
    if player.vehicle and player.vehicle.valid then
      failure_message = {"message-sitting-in-vehicle"}
      player.print(failure_message)
      return false
    end
    if not global.Teleportation.player_settings[player.name].used_portal_on_tick then
      global.Teleportation.player_settings[player.name].used_portal_on_tick = 0
    end
    local ticks_passed_since_last_use = game.tick - global.Teleportation.player_settings[player.name].used_portal_on_tick
    if ticks_passed_since_last_use < cooldown_in_ticks_between_usages then
      if ticks_passed_since_last_use > 15 then
        player.print({"message-too-frequent-use-portal", cooldown_in_ticks_between_usages / 60})
      end
      return
    else
      local distance = Common_GetDistanceBetween(player.position, destination_position)
      local energy_required = Teleportation.config.energy_in_equipment_to_use_portal * distance
      local equipment_energy = Teleportation_GetPlayerEquipmentChargeLevel(player)
      if equipment_energy >= 0 then
        if equipment_energy >= energy_required then
          local valid_position = Teleportation_CheckDestinationPosition(destination_position, player)
          if valid_position then
            Teleportation_BlockProjectiles(player)
            player.teleport(valid_position, player.surface)
            global.Teleportation.player_settings[player.name].used_portal_on_tick = game.tick
            Teleportation_DischargeEquipment(player, energy_required)
            return true
          else
            return false
          end
        else --equipment_energy < energy_required
          local failure_message = {"message-no-power-pt", math.floor(equipment_energy * 100 / energy_required)}
          player.print(failure_message)
          return false
        end
      else
        local failure_message = {"message-no-equipment"}
        player.print(failure_message)
        return false
      end
    end
	end
end

function Teleportation_DischargeEquipment(player, energy_to_discharge)
  if player ~= nil and player.valid and player.connected then
    local armor_as_item_stack = player.get_inventory(defines.inventory.player_armor)[1]
    if armor_as_item_stack and armor_as_item_stack.valid and armor_as_item_stack.valid_for_read and armor_as_item_stack.grid and armor_as_item_stack.grid.valid then
      local equipment = armor_as_item_stack.grid.equipment
      for i, item in pairs(equipment) do
        if item.name == "teleportation-equipment" then
          if item.energy >= energy_to_discharge then
            item.energy = item.energy - energy_to_discharge
            return
          else
            energy_to_discharge = energy_to_discharge - item.energy
            item.energy = 0
          end
        end
      end
    end
  end
end

--Tries to find the nost charged beacon, the player stays on
function Teleportation_GetSendingBeaconUnderPlayer(player)
  local beacons_under_player = player.surface.find_entities_filtered({name = "teleportation-beacon", position = player.position})
  if beacons_under_player and #beacons_under_player > 0 then
    local most_charged_beacon
    for i, beacon_entity in pairs(beacons_under_player) do
      local beacon = Common_GetBeaconByKey(Common_CreateEntityKey(beacon_entity))
      if beacon then
        if not most_charged_beacon then
          most_charged_beacon = beacon
        end
        if most_charged_beacon.energy_interface.energy < beacon.energy_interface.energy then
          most_charged_beacon = beacon
        end
      end
    end
    return most_charged_beacon
  else
    return false
  end
end

--Gets the most charged equipment to teleport
function Teleportation_GetPlayerEquipmentChargeLevel(player)
  local charge_level = 0
  if player ~= nil and player.valid and player.connected then
    local armor_as_item_stack = player.get_inventory(defines.inventory.player_armor)[1]
    if armor_as_item_stack and armor_as_item_stack.valid and armor_as_item_stack.valid_for_read and armor_as_item_stack.grid and armor_as_item_stack.grid.valid then
      local equipment = armor_as_item_stack.grid.equipment
      local has_equipment = false
      for i, item in pairs(equipment) do
        if item.name == "teleportation-equipment" then
          has_equipment = true
          charge_level = charge_level + item.energy
        end
      end
      if not has_equipment then return -1 end
    end
  end
  return charge_level
end

--Returns non-colliding position (neighboring to the position targeted with jump targeter) where player can teleport to
function Teleportation_CheckDestinationPosition(position, player)
  if player.surface.can_place_entity({name = player.character.name, position = position}) or settings.get_player_settings(player)["Teleportation-straight-jump-ignores-collisions"].value then
    return position
  else
    local position = player.surface.find_non_colliding_position(player.character.name, position, 2, 1)
    if position then
      return position
    end
  end
  player.print({"message-invalid-destination"})
  return false
end

--Teleports player to the defined position on the defined surface
function Teleportation_Teleport(player, surface_name, destination_position)
  surface_name = surface_name or "nauvis"
  --player.teleport({destination_position.x-0.3, destination_position.y + 0.1}, surface_name)
  player.teleport({destination_position.x, destination_position.y+0.1}, surface_name)
end

--Destroys enemies' projectiles neighboring to the player to prevent them from homing behavior after player's teleportation.
function Teleportation_BlockProjectiles(player)
  local radius = 30
  local area = {{x = player.position.x - radius, y = player.position.y - radius}, {x = player.position.x + radius, y = player.position.y + radius}}
  for i, entity in pairs(player.surface.find_entities_filtered{area = area, name="acid-projectile-purple"}) do
    entity.destroy()
  end
end

--===================================================================--
--############################### GUI ###############################--
--===================================================================--

function Teleportation_ProcessGuiClick(element)
  local gui_element = element
  local player_index = element.player_index
  local player = game.players[player_index]
  if gui_element.name == "teleportation_main_button" then                 -- Main mod's button
    Teleportation_SwitchMainWindow(game.players[player_index])
  elseif gui_element.name == "teleportation_button_page_back" then      -- < -button, prev.page
    Teleportation_InitializePlayerGlobals(player)
    if global.Teleportation.player_settings[player.name].beacons_list_current_page_num > 1 then
      global.Teleportation.player_settings[player.name].beacons_list_current_page_num = global.Teleportation.player_settings[player.name].beacons_list_current_page_num - 1
      Teleportation_UpdateMainWindow(player)
    end
  elseif gui_element.name == "teleportation_button_page_forward" then      -- > -button, next page
    Teleportation_InitializePlayerGlobals(player)
    global.Teleportation.player_settings[player.name].beacons_list_current_page_num = global.Teleportation.player_settings[player.name].beacons_list_current_page_num + 1
    Teleportation_UpdateMainWindow(player)
  elseif gui_element.name == "teleportation_button_sort_global" then      -- G -button, no sorting
    Teleportation_InitializePlayerGlobals(player)
    global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by = 1
    Teleportation_UpdateMainWindow(player)
  elseif gui_element.name == "teleportation_button_sort_distance_from_player" then -- P -button, by distance from player
    Teleportation_InitializePlayerGlobals(player)
    global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by = 3
    Teleportation_UpdateMainWindow(player)
  elseif gui_element.name == "teleportation_button_sort_distance_from_start" then  -- S -button, by distance from start
    Teleportation_InitializePlayerGlobals(player)
    global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by = 2
    Teleportation_UpdateMainWindow(player)
  elseif gui_element.name == "teleportation_button_sort_alphabet" then  -- A -button, by alphabet
    Teleportation_InitializePlayerGlobals(player)
    global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by = 4
    Teleportation_UpdateMainWindow(player)
  elseif gui_element.name == "teleportation_button_activate" then         -- T -button (teleport)
    Teleportation_ActivateBeacon(player, gui_element.parent.name)
  elseif gui_element.name == "teleportation_button_order_up" then         -- < -button (move up)
    if Teleportation_ReorderBeaconUp(gui_element.parent.name, player.force.name, player) then
      Teleportation_UpdateMainWindow(player)
    end
  elseif gui_element.name == "teleportation_button_order_down" then       -- > -button (move down)
    if Teleportation_ReorderBeaconDown(gui_element.parent.name, player.force.name, player) then
      Teleportation_UpdateMainWindow(player)
    end
  elseif gui_element.name == "teleportation_button_rename" then
    Teleportation_OpenRenameWindow(player, gui_element.parent.name)
  elseif gui_element.name == "teleportation_rename_window_button_cancel" then
    Teleportation_CloseRenameWindow(player)
  elseif gui_element.name == "teleportation_rename_window_button_ok" then
    Teleportation_SaveNewBeaconsName(player, gui_element.parent.name)
    Teleportation_UpdateGui(player.force)
  end
end

--Updates GUI for all players of a given LuaForce. If this force owns any beacons - it's members will see them.
function Teleportation_UpdateGui(force, force_update)
  Teleportation_InitializeGeneralGlobals()
  local number_of_beacons_belonging_to_force = Teleportation_CountBeacons(force.name)
  for i, player in pairs(force.players) do
    Teleportation_InitializePlayerGlobals(player)
    if force_update then
      Teleportation_HideMainButton(player)
      Teleportation_HideMainWindow(player)
    end
    if number_of_beacons_belonging_to_force == 0 then
      Teleportation_HideMainButton(player)
      Teleportation_HideMainWindow(player)
    else
      Teleportation_ShowMainButton(player)
      Teleportation_UpdateMainWindow(player)
    end
  end
end

--Shows mod's main button in player's GUI.
function Teleportation_ShowMainButton(player)
  if player ~= nil and player.valid then
    local gui = player.gui.top
    if not gui.teleportation_main_button then
      local button = gui.add({type="button", name="teleportation_main_button", style = "teleportation_main_button_style"})
      button.tooltip = {"tooltip-button-main"}
    end
  end
end

--Hides mod's main button for player.
function Teleportation_HideMainButton(player)
  if player ~= nil and player.valid then
    local gui = player.gui.top
    if gui.teleportation_main_button then
      gui.teleportation_main_button.destroy()
    end
  end
end

--Opens mod's main window for player.
function Teleportation_ShowMainWindow(player)
  if player ~= nil and player.valid and player.connected then
    local gui = player.gui.left
    if not gui.teleportation_main_window then
      local window = gui.add({type="flow", name="teleportation_main_window", direction="vertical"})
      local grid = window.add({type="table", name="teleportation_main_window_grid", column_count=2})
      grid.style.cell_spacing = 0
      grid.style.horizontal_spacing = 0
      grid.style.vertical_spacing = 0
      local window_menu_paging = grid.add({type="frame", name="teleportation_window_menu_paging", direction="horizontal", style="teleportation_thin_frame"})
      local buttonFlow = window_menu_paging.add({type="flow", name="teleportation_paging", direction="horizontal", column_count=2})
      local button
      button = buttonFlow.add({type="button", name="teleportation_button_page_back", style="teleportation_button_style_arrow_left"})
      button.tooltip = {"tooltip-button-page-prev"}
      buttonFlow.add({type="label", name="teleportation_label_page_number", caption="21-30/500", style="teleportation_label_style"})
      button = buttonFlow.add({type="button", name="teleportation_button_page_forward", style="teleportation_button_style_arrow_right"})
      button.tooltip = {"tooltip-button-page-next"}
      local window_menu_sorting = grid.add({type="frame", name="teleportation_window_menu_sorting", direction="horizontal", style="teleportation_thin_frame"})
      buttonFlow = window_menu_sorting.add({type="flow", name="teleportation_buttons_sorting", direction="horizontal", column_count=2})
      buttonFlow.add({type="label", name="teleportation_sorting_label", caption={"label-sort-by"}, style="teleportation_label_style"})
      button = buttonFlow.add({type="button", name="teleportation_button_sort_global", style="teleportation_button_style_globus"})
      button.tooltip = {"tooltip-button-sort-global"}
      button = buttonFlow.add({type="button", name="teleportation_button_sort_distance_from_player", style="teleportation_button_style_sort_from_player"})
      button.tooltip = {"tooltip-button-sort-distance-from-player"}
      button = buttonFlow.add({type="button", name="teleportation_button_sort_distance_from_start", style="teleportation_button_style_sort_from_start"})
      button.tooltip = {"tooltip-button-sort-distance-from-start"}
      button = buttonFlow.add({type="button", name="teleportation_button_sort_alphabet", style="teleportation_button_style_sort_alphabet"})
      button.tooltip = {"tooltip-button-sort-alphabet"}
      Teleportation_UpdateMainWindow(player)
    end
  end
end

--Updates GUI-list of beacons, if player's mod's window is opened. All sortings are beeing initiated from this function.
function Teleportation_UpdateMainWindow(player)
  if player ~= nil and player.valid and player.connected then
    local gui = Teleportation_GetBeaconsButtonsGrid(player)
    if gui then
      --[[At first we'll remove existing rows (except window menu - first two gui elements in table).
          If we'll do it in straight order, then the first column of table will be as wide as the second.]]
      for i = #gui.children_names, 1, -1 do
        local gui_name = gui.children_names[i]
        if not string.find(gui_name, "window_menu") then
          gui[gui_name].destroy()
        end
      end
      local list = global.Teleportation.beacons
      Teleportation_InitializePlayerGlobals(player)
      local list_sorted = Teleportation_GetBeaconsSorted(list, player.force.name, global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by, player)
      local list_page, current_page_num, total_pages_num = Teleportation_GetListPage(player, list_sorted, global.Teleportation.player_settings[player.name].beacons_list_current_page_num, settings.get_player_settings(player)["Teleportation-page-size"].value)
      gui.teleportation_window_menu_paging.teleportation_paging.teleportation_label_page_number.caption = current_page_num .. "/" .. total_pages_num
      --Now let's add by one row for each beacon.
      for i, beacon in pairs(list_page) do
        local player_force = player.force.name
        local beacon_force = beacon.entity.force.name
        if player.force.name == beacon.entity.force.name or settings.global["Teleportation-all-beacons-for-all"].value then
          Teleportation_InitializePlayerGlobals(player)
          local sort_type = global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by
          Teleportation_AddRow(gui, beacon, i, sort_type)
        end
      end
    end
  end
end

--Closes mod window for player.
function Teleportation_HideMainWindow(player)
  if player ~= nil and player.valid then
    local gui = player.gui.left
    if gui.teleportation_main_window then
      gui["teleportation_main_window"].destroy()
    end
  end
end

--Closes opened mod window for player and opens closed window.
function Teleportation_SwitchMainWindow(player)
  if player ~= nil and player.valid and player.connected then
    if not player.gui.top.teleportation_main_button then
      return
    end
    local gui = player.gui.left
    if gui.teleportation_main_window then
      Teleportation_HideMainWindow(player)
    else
      Teleportation_ShowMainWindow(player)
    end
  end
end

--Adds rob with buttons and labels. One row represents one beacon. Index-based naming is not good, because rows should be sortable.
function Teleportation_AddRow(container, beacon, index, sort_type)
  local frame = container.add({type="frame", name="teleportation_buttons_tools_" .. index, direction="horizontal", style="teleportation_thin_frame"})
  local buttonFlow = frame.add({type="flow", name=beacon.key, direction="horizontal"})
  buttonFlow.add({type="button", name="teleportation_button_activate", style="teleportation_button_style_teleport"})
  local button = buttonFlow.add({type="button", name="teleportation_button_rename", style="teleportation_button_style_edit"})
	button.tooltip = {"tooltip-button-rename"}
  if sort_type == 1 then
    local replacerFlow = buttonFlow.add({type="flow", name=beacon.key, direction="vertical"})
    replacerFlow.add({type="button", name="teleportation_button_order_up", style="teleportation_button_style_arrow_up"})
    replacerFlow.add({type="button", name="teleportation_button_order_down", style="teleportation_button_style_arrow_down"})
  end
  frame = container.add({type="frame", name=beacon.key, direction="horizontal", style="teleportation_thin_frame"})
  local flow = frame.add({type="flow", name=beacon.key, direction="vertical"})
  local label = flow.add({type="label", name="teleportation_label_beacons_name", caption=beacon.name, style="teleportation_label_style"})
  label.style.top_padding = 0
  local progress = flow.add({type="progressbar", name="teleportation_beacon_energy_progressbar", size=150, value=beacon.energy_interface.energy/beacon.energy_interface.electric_buffer_size--[[, style="teleportation_beacon_energy_progressbar"]]})
  progress.style.top_padding = 0
end

--Returns GUI-container for putting rows representing beacons. If mod window is hidden for the specified player, returns nil.
function Teleportation_GetBeaconsButtonsGrid(player)
  if player.gui.left.teleportation_main_window then
    local container = player.gui.left["teleportation_main_window"]
    if container.teleportation_main_window_grid then
      container = container["teleportation_main_window_grid"]
      return container
    end
  end
  return nil
end

function Teleportation_OpenRenameWindow(player, beacon_key)
  local gui = player.gui.center
  if gui.teleportation_rename_window then
    return
  end
  local beacon = Common_GetBeaconByKey(beacon_key)
  local frame = gui.add({type="frame", name="teleportation_rename_window", direction="vertical", caption={"caption-rename-window"}})
  local text_box = frame.add({type="textfield", name="teleportation_rename_textbox", style="teleportation_textbox"})
  text_box.text = beacon.name
  local flow = frame.add({type="flow", name=beacon.key, direction="horizontal"})
  flow.add({type="button", name = "teleportation_rename_window_button_cancel", caption={"caption-button-cancel"}})
  flow.add({type="button", name = "teleportation_rename_window_button_ok" , caption={"caption-button-ok"}})
end

function Teleportation_CloseRenameWindow(player)
  local gui = player.gui.center
  if gui.teleportation_rename_window then
    gui.teleportation_rename_window.destroy()
  end
end

function Teleportation_SaveNewBeaconsName(player, beacon_key)
  local gui = player.gui.center
  if not gui.teleportation_rename_window then
    return
  end
  local beacon = Common_GetBeaconByKey(beacon_key)
  local new_name = gui.teleportation_rename_window.teleportation_rename_textbox.text
  if string.len(new_name) < 2 then
    new_name = Common_CreateEntityName(beacon.entity)
  end
  beacon.name = new_name
  if beacon.marker and beacon.marker.valid then
		beacon.marker.text = new_name
	else
		local chart_tag = {
			icon = {type = "item", name = "teleportation-portal"},
			position = beacon.entity.position,
			text = new_name,
			last_user = beacon.entity.last_user,
			target = beacon.entity
		}
		beacon.marker = beacon.entity.force.add_chart_tag(beacon.entity.surface, chart_tag)
	end
  gui.teleportation_rename_window.destroy()
end

function Teleportation_EnergyProgressUpdate()
  for i, player in pairs(game.players) do
    --UpdateMainWindow(player) -- it's too ineffective to repeat GUI recreation, it's better to update it (see below)
    local gui = Teleportation_GetBeaconsButtonsGrid(player)
    if gui then
      for i = #gui.children_names, 1, -1 do
        local gui_name = gui.children_names[i]
        if not string.find(gui_name, "window_menu") then
          if gui[gui_name][gui_name] and gui[gui_name][gui_name]["teleportation_beacon_energy_progressbar"] then
            local beacon = Common_GetBeaconByKey(gui_name)
            if beacon and Common_IsEntityOk(beacon.energy_interface) then
              gui[gui_name][gui_name]["teleportation_beacon_energy_progressbar"].value = beacon.energy_interface.energy / beacon.energy_interface.electric_buffer_size
            end
          end
        end
      end
    end
  end
end

function Teleportation_ShowBeaconReminder(beacon, player)
  if not beacon then return end
  local window
  local progress
  if not player.gui.center["teleportation_beacon_reminder"] then
    window = player.gui.center.add({type="frame", name="teleportation_beacon_reminder", caption=beacon.name})
    progress = window.add({type="progressbar", name="teleportation_beacon_energy_progressbar", size=400--[[, style="teleportation_beacon_energy_progressbar"]]})
  else
    window = player.gui.center["teleportation_beacon_reminder"]
    progress = window["teleportation_beacon_energy_progressbar"]
  end
  progress.value = beacon.energy_interface.energy/beacon.energy_interface.electric_buffer_size
end

function Teleportation_CloseBeaconReminder(player)
  if player.gui.center["teleportation_beacon_reminder"] then
    player.gui.center["teleportation_beacon_reminder"].destroy()
  end
end

--===================================================================--
--############################ MIGRATIONS ###########################--
--===================================================================--
function Teleportation_Migrate() 
  for i, force in pairs(game.forces) do
    Teleportation_UpdateGui(force, true)
  end
  if game.active_mods["Teleportation"]:IsGreaterOrEqual("0.15.0") then
    -- Recollect all beacons
    Teleportation_RefreshBeaconsAndMakeTheirEntitiesUnoperable()
    if global.Teleportation and global.Teleportation.beacons and #global.Teleportation.beacons > 0 then
      for i = #global.Teleportation.beacons, 1, -1 do
        local beacon = global.Teleportation.beacons[i]
        if beacon.entity == nil or not beacon.entity.valid then
          table.remove(global.Teleportation.beacons, i)
          next()
        end
        if beacon.marker then
          if beacon.marker.valid then
            beacon.marker.destroy()
          end
          beacon.marker = nil
        end
        local chart_tag = {
          icon = {type = "item", name = "teleportation-portal"},
          position = beacon.entity.position,
          text = beacon.name,
          last_user = beacon.entity.last_user,
          target = beacon.entity
        }
        beacon.marker = beacon.entity.force.add_chart_tag(beacon.entity.surface, chart_tag)
      end
    end
  end
end

function Teleportation_RefreshBeaconsAndMakeTheirEntitiesUnoperable()
  local beacons_entities = {}
  for i, surface in pairs(game.surfaces) do
    -- Find all beacons on all surfaces
    local beacons_entities_on_surface = surface.find_entities_filtered({name="teleportation-beacon"})
    for bi, beacon_entity in pairs(beacons_entities_on_surface) do
      --table.insert(beacons_entities, beacon_entity)
      beacon_entity.operable = false
      beacon_entity.active = false
      local beacon_key = Common_CreateEntityKey(beacon_entity)
      local beacon_from_list = Common_GetBeaconByKey(beacon_key)
      if beacon_from_list then
        beacon_from_list.entity = beacon_entity
      end
    end
  end
end