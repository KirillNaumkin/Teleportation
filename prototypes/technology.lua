data:extend({
  {
    type = "technology",
    name = "teleportation-tech",
    icon = "__Teleportation__/graphics/technology_icon.png",
	  effects =
	  {
	    {
        type = "unlock-recipe",
        recipe = "teleportation-beacon"
      }
	  },
    prerequisites = {"logistic-system", "alien-technology"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"alien-science-pack", 1}
      },
      time = 60
    }
  },
  {
    type = "technology",
    name = "teleportation-tech-adv",
    icon = "__Teleportation__/graphics/technology_adv_icon.png",
	  effects =
	  {
      {
        type = "unlock-recipe",
        recipe = "teleportation-equipment"
      },
      {
        type = "unlock-recipe",
        recipe = "teleportation-portal",
      }
	  },
    prerequisites = {"teleportation-tech", "fusion-reactor-equipment", "rocket-silo"},
    unit =
    {
      count = 2000,
      ingredients =
      {
        {"science-pack-1", 5},
        {"science-pack-2", 5},
        {"science-pack-3", 5},
        {"alien-science-pack", 5}
      },
      time = 15
    }
  }
})
