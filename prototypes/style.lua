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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {48, 48},
      position = {64, 96}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {48, 48},
      position = {112, 96}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {48, 48},
      position = {112, 96}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {0, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {0, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {0, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {32, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {32, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32,32},
      position = {32, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {64, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {64, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {64, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {96, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {96, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {96, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {128, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {128, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {128, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {160, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {160, 32},
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {160, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {16, 32},
      position = {192, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {16, 32},
      position = {192, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {16, 32},
      position = {192, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {16, 32},
      position = {208, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {16, 32},
      position = {208, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {16, 32},
      position = {208, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {0, 96}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {0, 112}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 16},
      position = {0, 128}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {32, 96}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {32, 112}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 16},
      position = {32, 128}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {160, 96}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {160, 112}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 16},
      position = {160, 128}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {224, 0}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 32},
      position = {224, 32}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 32},
      position = {224, 64}
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
  font = "default",
  default_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {192, 96}
  },
  hovered_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      priority = "extra-high-no-scale",
      size = {32, 16},
      position = {192, 96}
  },
  clicked_graphical_set =
  {
      filename = "__Teleportation__/graphics/buttons.png",
      size = {32, 16},
      position = {192, 96},
  },
  left_click_sound =
  {
    filename = "__core__/sound/gui-click.ogg",
    volume = 1
  }
}

data.raw["gui-style"].default["teleportation_textbox"] = {
  type = "textbox_style",
  --parent = "textfield_style",
    minimal_width = 300,
    maximal_width = 300,
}


