if debug_hud {
    draw_text(4, 4, string(sock))
    draw_text(4, 20, json_stringify(clients))
    draw_text(4, 36, json_stringify(client_insts))
}