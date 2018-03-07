require("prototypes.recipe")
require("prototypes.item")
require("prototypes.entity")
require("prototypes.technology")
require("prototypes.equipment")
require("prototypes.style")
require("prototypes.hotkey")

data:extend({
	{
		type = "explosion",
		name = "teleport-sound-effect",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Teleportation__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		{
			filename = "__Teleportation__/sound/teleport.ogg",
			volume = 0.4
		},
		},
	}
})
