
--===================================================================--
--############################ FUNCTIONS ############################--
--===================================================================--

--Calculates key for entity depending on it's position. It's entity's UID.
function Common_CreateEntityKey(entity)
  return entity.surface.name .. "-" .. entity.position.x .. "-" .. entity.position.y
end

--Calculates key for entity depending on it's position. It's entity's UID.
function Common_CreateEntityName(entity)
  return "x:" .. entity.position.x .. ", y:" .. entity.position.y .. ", s:" .. entity.surface.name
end

--Function to shorten checks
function Common_IsPlayerOk(player)
  return player and player.connected and player.valid
end

--Function to shorten checks
function Common_IsEntityOk(entity)
  return entity and entity.valid
end

--Checks if player is holding defined item in his hand
function Common_IsHolding(stack, player) -- thanks to supercheese (Orbital Ion Cannon author)
	local holding = player.cursor_stack
	if holding and holding.valid_for_read and (holding.name == stack.name) and (holding.count >= stack.count) then
		return true
	end
	return false
end

function Common_GetDistanceBetween(position1, position2)
  return math.sqrt(math.pow(position2.x - position1.x, 2) + math.pow(position2.y - position1.y, 2))
end

--Looks for beacon with specified key and returns the beacon and it's index in global list
function Common_GetBeaconByKey(beacon_key)
  if global.Teleportation ~= nil and global.Teleportation.beacons ~= nil then
    for i, beacon in pairs(global.Teleportation.beacons) do
      if beacon.key == beacon_key then
        return beacon, i
      end
    end
  end
  return nil
end

function Common_GetTeleproviderByKey(provider_key)
  if global.Telelogistics ~= nil and global.Telelogistics.teleproviders ~= nil then
    for i, provider in pairs(global.Telelogistics.teleproviders) do
      if provider.key == provider_key then
        return provider, i
      end
    end
  end
  return nil
end

function string:Split(separator)
  local separator = separator or "."
  local fields = {}
  local pattern = string.format("([^%s]+)", separator)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

--Compares versions (e.g. "0.13.1" > "0.12.5")
function string:IsGreaterOrEqual(version_to_compare)
  local cur_ver = self:Split(".")
  local another_ver = version_to_compare:Split(".")
  for k,v in pairs(cur_ver) do
    local cur_ver_val = tonumber(v) or 0
    local another_ver_val = tonumber(another_ver[k]) or 0
    if cur_ver_val < another_ver_val then
      return false
    end
  end
  return true
end
