if debug_hud {
    draw_text(4, 4, string(sock))
    draw_text(4, 20, json_stringify(clients))
    draw_text(4, 36, json_stringify(client_insts))
}
if menu {
	var str = $"Press SPACE to host a server\nPress ENTER to join one\nPress Backspace to disconnect\nname: {name_entry} (R to reroll)"

	draw_text(4, 4, str)
}