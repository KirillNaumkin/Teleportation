local portal_targeter = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

portal_targeter.name = "teleportation-portal"
portal_targeter.icon = "__Teleportation__/graphics/portal-32.png"
portal_targeter.flags = {"placeable-neutral", "player-creation","placeable-off-grid"}
portal_targeter.collision_mask = {}
portal_targeter.max_health = 0
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
	range = 0,
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

data:extend({
  {
    type = "accumulator",
    name = "teleportation-beacon",
    icon = "__Teleportation__/graphics/icon.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "teleportation-beacon"},
    max_health = 150,
    corpse = "medium-remnants",
    collision_box = {{-2, -2}, {2,2}},
    collision_mask = {"water-tile", "item-layer", "object-layer"},
    selection_box = {{-2, -2}, {2, 2}},
    render_layer = decorative,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "300MJ",
      usage_priority = "terciary",
      input_flow_limit = "5MW",
      output_flow_limit = "0W"
    },
    picture =
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
      filename = "__Teleportation__/graphics/tiers/orange/spritesheet.png",
      width = 128,
      height = 128,
      line_length = 16,
      frame_count = 16,
      shift = {0, 0},
      animation_speed = 0.5
    },
    discharge_cooldown = 60,
    discharge_light = {intensity = 0.7, size = 7},
  }
})