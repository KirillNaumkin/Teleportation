data.raw["gui-style"].default["teleportation_thin_flow"] = {
  type = "flow_style",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  max_on_row = 0,
  resize_row_to_width = true, 
}
data.raw["gui-style"].default["teleportation_button_flow"] = {
  type = "flow_style",
  --parent="flow_style",
  horizontal_spacing=1,
}
data.raw["gui-style"].default["teleportation_thin_frame"] = {
  type = "frame_style",
  --parent="frame_style",
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
  --parent = "button_style",
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
data.raw["gui-style"].default["teleportation_main_button_style"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 48,
      height = 48,
      x = 64,
      y = 96,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 48,
      height = 48,
      x = 112,
      y = 96,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 48,
      height = 48,
      x = 112,
      y = 96,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_teleport"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 0,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 0,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 0,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_edit"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 32,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 32,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 32,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_globus"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 64,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 64,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 64,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_sort_alphabet"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 96,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 96,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 96,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_sort_from_player"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 128,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 128,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 128,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_sort_from_start"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 160,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 160,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 160,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_arrow_left"] = {
  type = "button_style",
  --parent = "button_style",
  width = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 16,
      height = 32,
      x = 192,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 16,
      height = 32,
      x = 192,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 16,
      height = 32,
      x = 192,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_arrow_right"] = {
  type = "button_style",
  --parent = "button_style",
  width = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 16,
      height = 32,
      x = 208,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 16,
      height = 32,
      x = 208,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 16,
      height = 32,
      x = 208,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_arrow_up"] = {
  type = "button_style",
  --parent = "button_style",
  width = 32,
  height = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 0,
      y = 96,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 0,
      y = 112,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 16,
      x = 0,
      y = 128,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_arrow_down"] = {
  type = "button_style",
  --parent = "button_style",
  width = 32,
  height = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 32,
      y = 96,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 32,
      y = 112,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 16,
      x = 32,
      y = 128,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_link_small"] = {
  type = "button_style",
  --parent = "button_style",
  width = 32,
  height = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 160,
      y = 96,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 160,
      y = 112,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 16,
      x = 160,
      y = 128,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_button_style_cancel_link"] = {
  type = "button_style",
  --parent = "button_style",
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 224,
      y = 0,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 32,
      x = 224,
      y = 32,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 32,
      x = 224,
      y = 64,
    }
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_sprite_style_done_small"] = {
  type = "button_style",
  --parent = "button_style",
  width = 32,
  height = 16,
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
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 192,
      y = 96,
    }
  },
  hovered_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      width = 32,
      height = 16,
      x = 192,
      y = 96,
    }
  },
  clicked_graphical_set =
  {
    type = "monolith",
    monolith_image =
    {
      filename = "__Teleportation__/graphics/buttons.png",
      width = 32,
      height = 16,
      x = 192,
      y = 96,
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
  --parent = "textfield_style",
    minimal_width = 300,
    maximal_width = 300,
}

