require("control-common")
require("control-teleportation")

--[[Global variables hierarchy in this part of mod:
  global
    Telelogistics = {}; dictionary
      teleproviders = {}; list
        entity = LuaEntity; contains such fields as built_by (last_user since 0.14.6), position, surface, force and so on - needed to operate with
        key = entity.surface.name .. "-" .. entity.position.x .. "-" .. entity.position.y; it's an id for gui elements representing this provider
        receiver_key = string; global.Teleportation.beacons[].key of the beacon receiving items from this provider
      index_of_last_processed_provider = number; for processing providers' queue
]]

--===================================================================--
--########################## EVENT HANDLERS #########################--
--===================================================================--

script.on_event("teleportation-hotkey-adjust-teleprovider", function(event)
  local player = game.players[event.player_index]
  if player.selected and player.selected.name == "teleportation-teleprovider" and player.selected.force.name == player.force.name then
    Telelogistics_OpenLinkerWindow(player, Common_CreateEntityKey(player.selected))
  end
end)

--===================================================================--
--############################ FUNCTIONS ############################--
--===================================================================--

--Ensures that globals were initialized.
function Telelogistics_InitializeGeneralGlobals()
  if not global.Telelogistics then
    global.Telelogistics = {}
  end
  if not global.Telelogistics.teleproviders then
    global.Telelogistics.teleproviders = {}
  end
end

--Saves built provider to the global list
function Telelogistics_RememberProvider(entity)
  Telelogistics_InitializeGeneralGlobals()
  local provider = {
    entity = entity,
    key = Common_CreateEntityKey(entity)
  }
  table.insert(global.Telelogistics.teleproviders, provider)
  --game.players[1].print("Remembered")
end

--Removes destroyed provider from the global list
function Telelogistics_ForgetProvider(entity)
  local key_to_forget = Common_CreateEntityKey(entity)
    for i = #global.Telelogistics.teleproviders, 1, -1 do
    local provider = global.Telelogistics.teleproviders[i]
    if provider.key == key_to_forget then
      table.remove(global.Telelogistics.teleproviders, i)
      --game.players[1].print("Forgot")
      return
    end
  end
end

function Telelogistics_LinkProviderWithBeacon(provider_key, beacon_key)
  local provider = Common_GetTeleproviderByKey(provider_key)
  local beacon = Common_GetBeaconByKey(beacon_key)
  if provider and beacon then
    provider.receiver_key = beacon_key
    --game.players[1].print("Linked")
  end
end

function Telelogistics_CancelProviderLink(provider_key)
  local provider = Common_GetTeleproviderByKey(provider_key)
  if provider then
    provider.receiver_key = nil
    --game.players[1].print("Unlinked")
  end
end

--Processes providers causing them to send items to the beacons
function Telelogistics_ProcessProvidersQueue()
  Telelogistics_InitializeGeneralGlobals()
  if #global.Telelogistics.teleproviders == 0 then return end
  local last_index = global.Telelogistics.index_of_last_processed_provider or 0
  local current_index = last_index + 1
  if global.Telelogistics.teleproviders[current_index] then
    Telelogistics_ProcessProvider(global.Telelogistics.teleproviders[current_index])
    global.Telelogistics.index_of_last_processed_provider = current_index
  else
    global.Telelogistics.index_of_last_processed_provider = 0
  end
end

function Telelogistics_ProcessProvider(provider)
  if not Common_IsEntityOk(provider.entity) then
    table.remove(global.Telelogistics.teleproviders, provider)
    --game.players[1].print("Processing: provider is not valid")
    return
  end
  if not provider.receiver_key then
    --game.players[1].print("Processing: receiver is not set")
    return
  end
  local beacon = Common_GetBeaconByKey(provider.receiver_key)
  if not beacon or not beacon.entity or not beacon.entity.valid then
    --game.players[1].print("Processing: not linked")
    provider.receiver_key = nil
    return
  end
  local beacon_inventory = beacon.entity.get_inventory(defines.inventory.chest)
  local provider_inventory = provider.entity.get_inventory(defines.inventory.chest)
  local provider_inventory_contents = provider_inventory.get_contents()
  for item_name, count in pairs(provider_inventory_contents) do
    if item_name and count then 
      local remainder = TopUpCount(beacon_inventory, item_name)
      if  remainder > 0 then
        -- Need to limit the amount we transfer to the amount availalble or the top-up value, whichever is smaller.
        local amount_to_transfer = count
        if amount_to_transfer  > remainder then amount_to_transfer = remainder end
        local inserted_count = beacon_inventory.insert({name = item_name, count = amount_to_transfer})
        if inserted_count > 0 then
          provider_inventory.remove({name = item_name, count = inserted_count})
          --game.players[1].print("Provider processed")
        end
      end
    end
  end
end

function TopUpCount(chest, name)
  local total_count=0
  -- loop over all items in the chest ant return a count of the total number of items in there
  -- not sure if different stacks of the same item show up as multiples so just assume they do
  -- and total them up
  local max_stack = 100 -- need to fill this in properly by queerying the stack size for this particular item
  local inventory_contents =chest.get_contents()
    for item_name, item_count in pairs(inventory_contents) do
      if item_name == name then
        total_count = total_count + item_count
      end
    end
  local remaining = max_stack - total_count
  if remaining >=0 then
    return remaining
  else
    return 0
  end
end

--===================================================================--
--############################### GUI ###############################--
--===================================================================--
function Telelogistics_ProcessGuiClick(gui_element)
  local player_index = gui_element.player_index
  local player = game.players[player_index]
  if gui_element.name == "teleportation_button_link_provider_with_beacon" then
    Telelogistics_LinkProviderWithBeacon(gui_element.parent.parent.name, gui_element.parent.name)
    Telelogistics_CloseLinkerWindow(player)
  elseif gui_element.name == "teleportation_linker_window_button_cancel_link" then
    Telelogistics_CancelProviderLink(gui_element.parent.name)
    Telelogistics_CloseLinkerWindow(player)
  elseif gui_element.name == "teleportation_linker_window_button_cancel" then
    Telelogistics_CloseLinkerWindow(player)
  end
end

function Telelogistics_OpenLinkerWindow(player, provider_key)
  local provider = Common_GetTeleproviderByKey(provider_key)
  if not provider then return end
  if not player.force.name == provider.entity.force.name then return end
  local gui = player.gui.center
  if gui.teleportation_linker_window then
    return
  end
  local window = gui.add({type="frame", name="teleportation_linker_window", direction="vertical", caption={"caption-linker-window"}})
  local scroll = window.add({type="scroll-pane", name="teleportation_linkable_beacons_scroll", direction="vertical"})
  scroll.style.maximal_height = 150
  scroll.style.minimal_width = 200
  local gui_table = scroll.add({type="table", name=provider_key, column_count=1})
  gui_table.style.cell_spacing = 0
  local list = global.Teleportation.beacons
  Teleportation_InitializePlayerGlobals(player)
  local list_sorted = Teleportation_GetBeaconsSorted(list, player.force.name, global.Teleportation.player_settings[player.name].beacons_list_is_sorted_by, player)
  for i, beacon in pairs(list_sorted) do
    local is_linked = false
    if provider.receiver_key == beacon.key then
      is_linked = true
    end
    Telelogistics_AddRow(gui_table, beacon, i, is_linked)
  end
  local buttons_flow = window.add({type="flow", name=provider_key, direction="horizontal"})
  buttons_flow.add({type="button", name = "teleportation_linker_window_button_cancel_link", style="teleportation_button_style_cancel_link"})
  buttons_flow.add({type="button", name = "teleportation_linker_window_button_cancel", caption={"caption-button-cancel"}})
end

function Telelogistics_AddRow(parent_gui, beacon, beacon_index, is_already_linked)
  local this_row = parent_gui.add({type="flow", name=beacon.key, direction="horizontal"})
  if is_already_linked then
    this_row.add({type="button", name="teleportation_sprite", style="teleportation_sprite_style_done_small"})
  else
    this_row.add({type="button", name="teleportation_button_link_provider_with_beacon", style="teleportation_button_style_link_small"})
  end
  this_row.add({type="label", name="teleportation_label_selectible_beacon_name", caption=beacon.name})
end

function Telelogistics_CloseLinkerWindow(player)
  local gui = player.gui.center
  if gui.teleportation_linker_window then
    gui.teleportation_linker_window.destroy()
  end
end