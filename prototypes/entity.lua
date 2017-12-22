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
	cooldown = 15,
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
    icon_size = 32,
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
    collision_box = {{-2, -2}, {1.9,1.9}},
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
      --shift = {0, 0}
      shift = {0.28, 0.2}
    }
    --[[picture =
    {
      filename = "__Teleportation__/graphics/null.png",
      priority = "high",
      width = 0,
      height = 0,
      shift = {0, 0}
    }]]
	},
  {
    type = "electric-energy-interface",
    name = "teleportation-beacon-electric-energy-interface",
    localised_name = {"entity-name.teleportation-beacon"},
    icon = "__Teleportation__/graphics/icon.png",
    icon_size = 32,
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
    {
      filename = "__Teleportation__/graphics/tiers/orange/spritesheet.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      line_length = 16,
      frame_count = 16,
      shift = {0, 0}
    },
    charge_animation =
    {
      filename = "__Teleportation__/graphics/tiers/orange/spritesheet.png",
      width = 128,
      height = 128,
      line_length = 16,
      frame_count = 16,
      shift = {0, 0},
      animation_speed = 0.5
    },
    charge_cooldown = 30,
    charge_light = {intensity = 0.3, size = 7},
    discharge_animation =
    {
      filename = "__PersonalTeleporter__/graphics/tiers/orange/spritesheet.png",
      width = 128,
      height = 128,
      line_length = 16,
      frame_count = 16,
      shift = {0, 0},
      animation_speed = 0.5
    },
    discharge_cooldown = 60,
    discharge_light = {intensity = 0.7, size = 7},
  },
})

if settings.startup["Teleportation-telelogistics-enabled"].value then
  local teleprovider = util.table.deepcopy(data.raw["container"]["steel-chest"])
  teleprovider.name = "teleportation-teleprovider"
  teleprovider.icon = "__Teleportation__/graphics/teleprovider-icon.png"
  teleprovider.icon_size = 32
  teleprovider.minable = {mining_time = 1, result = "teleportation-teleprovider"}
  teleprovider.inventory_size = 1
  teleprovider.picture = {
    filename = "__Teleportation__/graphics/teleprovider-entity.png",
    priority = "extra-high",
    width = 38,
    height = 32,
    shift = {0.09375, 0}
  }
  data:extend({teleprovider})
end