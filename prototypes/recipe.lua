data:extend({
	{
		type = "recipe",
		name = "teleportation-beacon",
		ingredients =
		{
			{"steel-plate", 100},
			{"copper-plate", 100},
			{"advanced-circuit", 100},
			{"alien-artifact",20}
		},
		result = "teleportation-beacon",
		enabled = "false"	
	},
	{
		type = "recipe",
		name = "teleportation-equipment",
		enabled = "false",
		energy_required = 10,
		ingredients = 
		{
			{"teleportation-beacon", 1},
			{"rocket-control-unit", 100},
			{"low-density-structure",50},
			{"fusion-reactor-equipment", 100}
		},
		result = "teleportation-equipment",
	},
  {
    type = "recipe",
    name = "teleportation-portal",
    ingredients = {
      {"fusion-reactor-equipment", 20},
      {"alien-artifact", 100}
    },
    result = "teleportation-portal",
    energy_required = 30,
    enabled = false
  }
})