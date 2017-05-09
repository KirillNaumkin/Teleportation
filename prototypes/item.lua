data:extend({
  {
      type  = "item-subgroup",
      name  = "teleportation",
      group = "logistics",
      order = "ba",
  },
  {
		type = "item",
		name = "teleportation-beacon",
		subgroup = "teleportation",
		icon = "__Teleportation__/graphics/icon.png",
		flags = { "goes-to-quickbar" },
		order = "a[items]-b[teleportation-beacon]",
		place_result="teleportation-beacon",
		stack_size= 5,
	},
  {
    type = "item",
    name = "teleportation-beacon-electric-energy-interface",
    icon = "__base__/graphics/icons/accumulator.png",
    flags = {"goes-to-quickbar", "hidden"},
    subgroup = "teleportation",
    order = "e[electric-energy-interface]-b[electric-energy-interface]",
    place_result = "teleportation-beacon-electric-energy-interface",
    stack_size = 1
  },
  {
    type = "item",
    name = "teleportation-equipment",
    icon = "__Teleportation__/graphics/Personal_Teleporter_item.png",
    flags = {"goes-to-main-inventory"},
    placed_as_equipment_result = "teleportation-equipment",
    subgroup = "equipment",
    order = "g-a-a",
    stack_size= 1,
  },
  {
    type = "item",
    name = "teleportation-portal",
    icon = "__Teleportation__/graphics/portal-32.png",
    flags = {"goes-to-quickbar"},
		subgroup = "capsule",
		order = "d[teleportation-portal]",
    place_result = "teleportation-portal",
    stack_size = 1
  },
})
if settings.startup["Teleportation-telelogistics-enabled"].value then
  data:extend({
    {
      type = "item",
      name = "teleportation-teleprovider",
      icon = "__Teleportation__/graphics/teleprovider-icon.png",
      flags = {"goes-to-quickbar"},
      subgroup = "teleportation",
      order = "a[items]-b[teleportation-teleprovider]",
      place_result = "teleportation-teleprovider",
      stack_size = 50
    },
  })
end
