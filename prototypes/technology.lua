data:extend({
	{
		type = "technology",
		name = "teleportation-tech",
		icon = "__Teleportation__/graphics/teleporter_icon.png",
		icon_size = 128,
		effects = {
			{
				type = "unlock-recipe",
				recipe = "teleportation-beacon"
			}
		},
		prerequisites = {"electric-energy-accumulators-1", "advanced-electronics"},
		unit = {
		count = 500,
			ingredients = {
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1}
			},
			time = 60
		}
	},
	{
		type = "technology",
		name = "teleportation-tech-adv",
		icon = "__Teleportation__/graphics/technology_adv_icon.png",
		icon_size = 128,
		effects =	{
			{
				type = "unlock-recipe",
				recipe = "teleportation-equipment"
			},
			{
				type = "unlock-recipe",
				recipe = "teleportation-portal",
			}
		},
		prerequisites = {"teleportation-tech", "fusion-reactor-equipment"},
		unit =
		{
			count = 2000,
			ingredients = {
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
				{"high-tech-science-pack", 1}
			},
			time = 15
		}
	}
})

if settings.startup["Teleportation-telelogistics-enabled"].value then
  data:extend({
    {
      type = "technology",
      name = "teleportation-telelogistics",
      icon = "__Teleportation__/graphics/telelogistics-technology.png",
      icon_size = 128,
      effects = {
        {
          type = "unlock-recipe",
          recipe = "teleportation-teleprovider"
        }
      },
      prerequisites = {"logistic-system"},
      unit = {
        count = 300,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
          {"science-pack-3", 1},
          {"production-science-pack", 1},
          {"high-tech-science-pack", 1}
        },
        time = 60
      }
    },
  })
end