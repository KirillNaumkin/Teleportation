local portal_targeter = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

portal_targeter.name = "teleportation-portal"
portal_targeter.icon = "__Teleportation__/graphics/portal-32.png"
portal_targeter.flags = {"placeable-neutral", "player-creation","placeable-off-grid"}
portal_targeter.collision_mask = {}
portal_targeter.max_health = 1
portal_targeter.inventory_size = 0
portal_targeter.collision_box = {{ 0, 0}, {0, 0}}
portal_targeter.selection_box = {{ 0, 0}, {0, 0}}
portal_targeter.folded_animation =
{
	layers =
	{
		{
			filename = "__Teleportation__/graphics/null.png",
			priority = "medium",
			width = 32,
			height = 32,
			frame_count = 1,
			line_length = 1,
			run_mode = "forward",
			axially_symmetrical = false,
			direction_count = 1,
			shift = {0, 0}
		}
	}
}
portal_targeter.base_picture =
{
	layers =
	{
		{
			filename = "__Teleportation__/graphics/portal-64.png",
			line_length = 1,
			width = 64,
			height = 64,
			frame_count = 1,
			axially_symmetrical = false,
			direction_count = 1,
			shift = {0, 0}
		}
	}
}
portal_targeter.attack_parameters =
{
	type = "projectile",
	ammo_category = "melee",
	cooldown = 30,
	projectile_center = {0, 0},
	projectile_creation_distance = 1.4,
	range = 2,
	damage_modifier = 0,
	ammo_type =
	{
		type = "projectile",
		category = "melee",
		energy_consumption = "0J"
	}
}

data:extend({portal_targeter})

data:extend({
  {
    type = "explosion",
    name = "teleport-sound",
    animation_speed = 5,
    animations =
    {
      {
        filename = "__Teleportation__/graphics/empty.png",
        priority = "extra-high",
        width = 33,
        height = 32,
        frame_count = 1,
        line_length = 1,
        shift = {0, 0}
      }
    },
    light = {intensity = 1, size = 20, color={r=0,g=0.3,b=1} },
    smoke = "smoke",
    smoke_count = 1,
    smoke_slow_down_factor = 1,
  }
})

--require ("prototypes.entity.demo-circuit-connector-sprites")
data:extend({
	{
		type = "container",
		name = "teleportation-beacon",
		icon = "__Teleportation__/graphics/icon.png",
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "teleportation-beacon"},
		max_health = 150,
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		resistances =
		{
			{
				type = "fire",
				percent = 90
			}
		},
    collision_box = {{-2, -2}, {2,2}},
    collision_mask = {"water-tile", "item-layer", "object-layer"},
    selection_box = {{-2, -2}, {2, 2}},
    render_layer = decorative,
		inventory_size = 10,
    picture =
    {
      filename = "__Teleportation__/graphics/tiers/orange/spritesheet.png",
      priority = "high",
      width = 128,
      height = 128,
      shift = {0, 0}
    }
    --[[circuit_wire_connection_point =
    {
      shadow =
      {
        red = {0.734375, 0.453125},
        green = {0.609375, 0.515625},
      },
      wire =
      {
        red = {0.40625, 0.21875},
        green = {0.40625, 0.375},
      }
    },
    circuit_connector_sprites = get_circuit_connector_sprites({0.1875, 0.15625}, nil, 18),
    circuit_wire_max_distance = 7.5]]
	},
  {
    type = "electric-energy-interface",
    name = "teleportation-beacon-electric-energy-interface",
    localised_name = {"entity-name.teleportation-beacon"},
    icon = "__Teleportation__/graphics/icon.png",
    flags = {"placeable-neutral", "player-creation", "not-blueprintable", "not-deconstructable"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "teleportation-beacon-electric-energy-interface"},
    destructible = false,
    selectable_in_game = false,
    max_health = 1,
    corpse = "medium-remnants",
    collision_box = {{-2, -2}, {2,2}},
    collision_mask = {"water-tile", "item-layer", "object-layer"},
    selection_box = {{0, 0}, {0, 0}},
    render_layer = decorative,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "300MJ",
      usage_priority = "secondary-input",
      input_flow_limit = "5MW",
      output_flow_limit = "0W"
    },
    picture =
    {
      filename = "__Teleportation__/graphics/null.png",
      priority = "extra-high",
      width = 0,
      height = 0,
      line_length = 0,
      frame_count = 0,
      shift = {0, 0}
    },
    charge_animation =
    {
      filename = "__Teleportation__/graphics/null.png",
      width = 0,
      height = 0,
      line_length = 0,
      frame_count = 0,
      shift = {0, 0},
      animation_speed = 0
    },
    charge_cooldown = 30,
    charge_light = {intensity = 0.3, size = 7},
    discharge_animation =
    {
      filename = "__Teleportation__/graphics/null.png",
      width = 0,
      height = 0,
      line_length = 0,
      frame_count = 0,
      shift = {0, 0},
      animation_speed = 0
    },
    discharge_cooldown = 60,
    discharge_light = {intensity = 0.7, size = 7},
  },
  {
		type = "train-stop",
		name = "teleportation-beacon-marker",
    localised_name = {"entity-name.teleportation-beacon"},
		icon = "__Teleportation__/graphics/null.png",
		flags = {"placeable-off-grid", "placeable-neutral", "player-creation", "filter-directions", "not-blueprintable", "not-deconstructable"},
    friendly_map_color = {r=1, g=1, b=0},
		order = "y",
		selectable_in_game = false,
		minable = {mining_time = 1, result = "train-stop"},
		max_health = 1,
		render_layer = "tile",
		final_render_layer = "tile",
		collision_box = {{0,0}, {0,0}},
		selection_box = {{0,0}, {0,0}},
		drawing_box = {{0,0}, {0,0}},
		tile_width = 1,
		tile_height = 1,
		animation_ticks_per_frame = 0,
	
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0 },
		working_sound =
		{
			sound = { filename = "__base__/sound/train-stop.ogg", volume = 0 }
		},
		circuit_wire_connection_points = {},
		circuit_connector_sprites =
		{
			get_circuit_connector_sprites({0.5625-1, 1.03125}, {0.5625-1, 1.03125}, 0), --N
			get_circuit_connector_sprites({-0.78125, 0.28125-1}, {-0.78125, 0.28125-1}, 6), --E
			get_circuit_connector_sprites({-0.28125+1, 0.28125}, {-0.28125+1, 0.28125}, 0), --S
			get_circuit_connector_sprites({0.03125, 0.28125+1}, {0.03125, 0.28125+1}, 6), --W
		},
	}
})

--[[
local telesender = util.table.deepcopy(data.raw["inserter"]["fast-inserter"])
telesender.name = "Test"
telesender.energy_source =
{
	type = "electric",
	usage_priority = "secondary-input",
	drain = "0.8kW"
}
telesender.name = "teleportation-telesender"
telesender.icon = "__Teleportation__/graphics/telesender-icon.png"
telesender.hand_base_picture =
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.hand_closed_picture = 
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.hand_open_picture =
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.hand_base_shadow =
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.hand_closed_shadow =
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.hand_open_shadow =
{
	filename = "__Teleportation__/graphics/null.png",
	width = 0,
	height = 0
}
telesender.platform_picture =
{
	sheet=
	{
		filename = "__Teleportation__/graphics/telesender-platform.png",
		priority = "extra-high",
		width = "46",
		height = "46"
	}
}

telesender.energy_per_movement = 4500
telesender.energy_per_rotation = 4500
telesender.rotation_speed = 1
telesender.extension_speed = 1
telesender.minable = {hardness = 0.2, mining_time = 0.5, result = "teleportation-telesender"}
data:extend({telesender})
]]