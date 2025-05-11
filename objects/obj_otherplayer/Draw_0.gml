draw_set_font(global.font)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1)
draw_text(x - string_width(name) / 2, bbox_top - 11, name)
