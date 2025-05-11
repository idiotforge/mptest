draw_set_font(global.font)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)
draw_set_alpha(1)
if menu {
    var str = ""
    str += (server != -1) ? "Connected!\n" : "Not connected.\n"
    if server == -1 {
        str += "Press SPACE to host a server\n"
        str += "Press ENTER to join one\n"
    } else {
        str += "Press Backspace to disconnect\n"
    }
    str += $"Name: {name_entry} (R to reroll)"
    draw_set_color(c_black)
    draw_set_alpha(0.8)
    draw_rectangle(0, 0, string_width(str) + 8, string_height(str) + 8, false)
    draw_set_color(c_white)
    draw_set_alpha(1)
	draw_text(4, 4, str)
}
var rm = room_get_name(room)
draw_set_color(c_black)
draw_set_alpha(0.8)
draw_rectangle(display_get_gui_width(), 0, display_get_gui_width() - string_width(rm) - 8, string_height(rm) + 8, false)
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_halign(fa_right)
draw_text(display_get_gui_width() - 4, 4, rm)
draw_set_halign(fa_left)