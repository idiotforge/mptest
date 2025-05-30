if keyboard_check_pressed(ord("M")) {
    menu = !menu
}

if menu {
    
    if keyboard_check_pressed(ord("R"))
        name_entry = random_name()
    
	// create server
	if keyboard_check_pressed(vk_space) {
		server = network_create_server(network_socket_tcp, port, maxclients)
	
		// fail
		if (server < 0) {
			show_error("could not create server", false)
		}
		// created
		else {
			room_goto(rm_test)
			is_server = true
			clients[0] = {
				name: name_entry,
				rm: string(room)
			}
		}
	}
    
	// join
	else if keyboard_check_pressed(vk_enter) {
		server = network_create_socket(network_socket_tcp)
        var _res = network_connect(server, ip, port)
        trace($"connecting to {ip}:{port}")
        // fail
        if (_res < 0) {
            trace("could not connect to server")
        }
        // connected
        else {
            trace("connected")
            room_goto(rm_test)
        }
	}
    
    // disconnect
    else if keyboard_check_pressed(vk_backspace) {
        network_destroy(server)
        instance_destroy(obj_netcontroller)
        for (var i = 0; i < array_length(client_insts); i++) {
            if instance_exists(client_insts[i]) && client_insts[i].object_index == obj_otherplayer {
                instance_destroy(client_insts[i])
            }
        }
        with instance_create_depth(0, 0, 0, obj_netcontroller) {
            name_entry = other.name_entry
        }
    }
}
if instance_exists(obj_player) {
	var _data = buffer_create(16, buffer_grow, 1)
    
	buffer_write(_data, buffer_u8, messages.playerdata)
    
    buffer_write(_data, buffer_u8, 0) // socket
    
	buffer_write(_data, buffer_f16, obj_player.x)
	buffer_write(_data, buffer_f16, obj_player.y)
    buffer_write(_data, buffer_s8, obj_player.image_xscale)
    
    buffer_write(_data, buffer_u16, obj_player.sprite_index)
    buffer_write(_data, buffer_u8, floor(obj_player.image_index))
    
	buffer_write(_data, buffer_string, string(room))
    
	if is_server {
		for (var _i = 1; _i < array_length(clients); _i++) {
            if clients[_i] != 0 {
                network_send_packet(_i, _data, buffer_get_size(_data))
            }
		}
	}
	else if sock != 0 {
        network_send_packet(server, _data, buffer_get_size(_data))
    }
}