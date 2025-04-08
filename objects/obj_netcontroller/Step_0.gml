if (room == rm_menu) {
	// Name entry
	name_entry = keyboard_string
	// Host
	if (keyboard_check_pressed(vk_space)) {
		server = network_create_server(network_socket_tcp, port, maxclients)
	
		// Failed
		if (server < 0) {
			show_error("Could not create server.", false)
		}
		// Created
		else {
			room_goto(rm_test)
			is_server = true
			clients[0] = {
				name: name_entry,
				rm: string(room)
			}
		}
	}
	// Join
	else if (keyboard_check_pressed(vk_enter)) {
		server = network_create_socket(network_socket_tcp)
		if (server < 0) {
			show_error("Could not start socket.", false)
		}
		else
		{
			var _res = network_connect(server, ip, port)
	
			// Failed
			if (_res < 0) {
				show_error("Could not connect to server.", false)
			}
			// Connected
			else {
				room_goto(rm_test)
			}
		}
	}
}
if instance_exists(obj_player)
{
	var _data = buffer_create(16, buffer_fixed, 1)
	buffer_write(_data, buffer_u8, messages.playerdata)
	buffer_write(_data, buffer_f16, obj_player.x)
	buffer_write(_data, buffer_f16, obj_player.y)
	buffer_write(_data, buffer_string, string(room))
	if is_server
	{
		for (var _i = 1; _i < array_length(clients); _i++)
		{
			network_send_raw(_i, _data, buffer_get_size(_data))
		}
	}
	else
		network_send_raw(server, _data, buffer_get_size(_data))
}