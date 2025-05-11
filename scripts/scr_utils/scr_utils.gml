function trace() {
	var r = string(argument[0]), i;
	for (i = 1; i < argument_count; i++) {
	    r += ", " + string(argument[i])
	}
	show_debug_message(r)
}
function multiclientsort() {
    var _id = MultiClientGetID()
    window_set_position(100 + ((_id > 1) ? ((_id - 2) * window_get_width()): ((_id) * window_get_width())), 100 + ((_id > 1) ? (window_get_height() + 32) : 0))
}