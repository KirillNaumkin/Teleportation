data:extend(
{
  {
    type = "battery-equipment",
    name = "teleportation-equipment",
    sprite =
    {
      filename = "__Teleportation__/graphics/Teleportation_equipment.png",
      width = 48,
      height = 48,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "100MJ",
      input_flow_limit = "500kW",
      output_flow_limit = "0W",
      usage_priority = "primary-input"
    },
    categories = {"armor"}
  },
})