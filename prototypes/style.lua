data.raw["gui-style"].default["teleportation_thin_flow"] = {
  type = "flow_style",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  max_on_row = 0,
  resize_row_to_width = true, 
}
data.raw["gui-style"].default["teleportation_button_flow"] = {
  type = "flow_style",
  parent="flow_style",
  horizontal_spacing=1,
}
data.raw["gui-style"].default["teleportation_thin_frame"] = {
  type = "frame_style",
  parent="frame_style",
  top_padding  = 2,
  bottom_padding = 2,
}
data.raw["gui-style"].default["teleportation_label_style"] = {
  type = "label_style",
  font = "default",
  font_color = {r=1, g=1, b=1},
  top_padding = 7,
  bottom_padding = 0,
}
data.raw["gui-style"].default["teleportation_button_style"] = {
  type = "button_style",
  parent = "button_style",
  top_padding = 1,
  right_padding = 5,
  bottom_padding = 1,
  left_padding = 5,
  left_click_sound =
  {
    {
      filename = "__core__/sound/gui-click.ogg",
      volume = 1
    }
  }
}
data.raw["gui-style"].default["teleportation_sprite_button_style"] = {
  type = "button_style",
  parent = "button_style",
  width = 32,
  height = 32,
  top_padding = 0,
  right_padding = 0,
  bottom_padding = 0,
  left_padding = 0,
  font = "default-button",
  default_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/button1.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      x = 0,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/button1.png",
      priority = "extra-high-no-scale",
      width = 64,
      height = 64,
      x = 64,
      y = 0,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/button1.png",
      width = 64,
      height = 64,
      x = 64,
      y = 0,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}
data.raw["gui-style"].default["teleportation_textbox"] = {
  type = "textfield_style",
  parent = "textfield_style",
    minimal_width = 300,
    maximal_width = 300,
}

data.raw["gui-style"].default["teleportation_placeholder"] = {
  type = "button_style",
  parent = "button_style",
  width = 33,
  height = 33,
}

