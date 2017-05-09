data:extend({
	{
		type = "recipe",
		name = "teleportation-beacon",
		enabled = false,
		ingredients =	{
			{"steel-plate", 100},
			{"copper-plate", 100},
			{"advanced-circuit", 100},
			{"accumulator", 100}
		},
		result = "teleportation-beacon",
		energy_required = 5
	},
	{
		type = "recipe",
		name = "teleportation-equipment",
		enabled = false,
		energy_required = 10,
		ingredients =	{
			{"teleportation-beacon", 1},
			{"speed-module", 100},
			{"plastic-bar", 100},
			{"copper-cable", 50},
			{"fusion-reactor-equipment", 15}
		},
		result = "teleportation-equipment",
	},
	{
		type = "recipe",
		name = "teleportation-portal",
		enabled = false,
		ingredients = {
			{"processing-unit", 10}
		},
		result = "teleportation-portal",
		energy_required = 30
	},
})
if settings.startup["Teleportation-telelogistics-enabled"].value then
  data:extend({
    {
      type = "recipe",
      name = "teleportation-teleprovider",
      enabled = false,
      ingredients =	{
        {"logistic-chest-active-provider", 1},
        {"advanced-circuit", 10},
        {"processing-unit", 1}
      },
      result = "teleportation-teleprovider",
      energy_required = 5
    },
  })
end