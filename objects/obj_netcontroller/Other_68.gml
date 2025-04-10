var _type = async_load[? "type"]

#region connection handling

// connected
if _type == network_type_connect {
    var _sock = async_load[? "socket"]
    trace("socket:  " + string(_sock))
    trace("server: " + string(server))
    // Send player info
    var _buffer = buffer_create(16, buffer_grow, 1)
    buffer_write(_buffer, buffer_u8, messages.playerinit)
    clients[_sock] = {
        name: "kenan238",
        rm: string(rm_init)
    }
    buffer_write(_buffer, buffer_u8, _sock)
    buffer_write(_buffer, buffer_string, json_stringify(clients))
    network_send_packet(_sock, _buffer, buffer_get_size(_buffer))
    buffer_delete(_buffer)
}
// disconnected
else if _type == network_type_disconnect {
    var _sock = async_load[? "socket"]
    clients[_sock] = 0
    if is_server {
        var _data = buffer_create(16, buffer_grow, 1)
        buffer_write(_data, buffer_u8, messages.updateclients)
        buffer_write(_data, buffer_string, json_stringify(clients))
        for (var _i = 1; _i < array_length(clients); _i++) {
            if clients[_i] != 0 {
                network_send_packet(_i, _data, buffer_get_size(_data))
            }
        }
        if instance_exists(client_insts[_sock]) && client_insts[_sock].object_index == obj_otherplayer {
            instance_destroy(client_insts[_sock])
            client_insts[_sock] = 0
        }
    }
        
}

#endregion

#region data handling

// ts pmo
else if _type == network_type_data {
	var _buffer = async_load[? "buffer"]
	var _sock = async_load[? "id"]
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	var _data = buffer_read(_buffer, buffer_u8)
	
	switch _data {
		// client-side
		case messages.playerinit:
			sock = buffer_read(_buffer, buffer_u8)
            clients = json_parse(buffer_read(_buffer, buffer_string))
            clients[sock].name = name_entry
			_data = buffer_create(16, buffer_grow, 1)
			buffer_write(_data, buffer_u8, messages.playerjoin)
			buffer_write(_data, buffer_string, name_entry)
			network_send_packet(server, _data, buffer_get_size(_data))
			break
        case messages.updateclients:
            clients = json_parse(buffer_read(_buffer, buffer_string))
            for (var _i = 1; _i < array_length(clients); _i++) {
                if clients[_i] == 0 && instance_exists(client_insts[_i]) && client_insts[_i].object_index == obj_otherplayer {
                    instance_destroy(client_insts[_i])
                    client_insts[_i] = 0
                }
    		}
            break
		// server-side
		case messages.playerjoin:
			clients[_sock].name = buffer_read(_buffer, buffer_string)
            trace(clients[_sock].name + " joined on socket " + string(_sock))
            if is_server {
                _data = buffer_create(16, buffer_grow, 1)
                buffer_write(_data, buffer_u8, messages.updateclients)
                buffer_write(_data, buffer_string, json_stringify(clients))
                for (var _i = 1; _i < array_length(clients); _i++) {
                    if clients[_i] != 0 && _sock != _i
        			    network_send_packet(_i, _data, buffer_get_size(_data))
        		}
            }
			break
            
		// both server and clientside
		case messages.playerdata:
            if !is_server {
                var _sock = buffer_read(_buffer, buffer_u8)
            }
            else {
            	buffer_seek(_buffer, buffer_seek_relative, 1)
            }
            var _x = buffer_read(_buffer, buffer_f16)
            var _y = buffer_read(_buffer, buffer_f16)
            var _rm = buffer_read(_buffer, buffer_string)
            clients[_sock].rm = _rm
            if instance_exists(client_insts[_sock]) && client_insts[_sock].object_index == obj_otherplayer {
                if clients[_sock].rm != string(room) {
                    instance_destroy(client_insts[_sock])
                    client_insts[_sock] = 0
                    break
                }
                    
                client_insts[_sock].x = _x
                client_insts[_sock].y = _y
            }
            else if clients[_sock].rm == string(room) && _sock != sock {
                var _plr = instance_create_depth(0, 0, 0, obj_otherplayer)
    			_plr.pid = _sock
    			_plr.name = clients[_sock].name
    			client_insts[_sock] = _plr.id
            }
            else if client_insts[_sock] != 0 {
                client_insts[_sock] = 0
            }
            if is_server {
                _data = buffer_create(16, buffer_grow, 1)
            	buffer_write(_data, buffer_u8, messages.playerdata)
                buffer_write(_data, buffer_u8, _sock)
            	buffer_write(_data, buffer_f16, _x)
            	buffer_write(_data, buffer_f16, _y)
            	buffer_write(_data, buffer_string, string(_rm))
                for (var _i = 1; _i < array_length(clients); _i++) {
                    if clients[_i] != 0 {
                        network_send_packet(_i, _data, buffer_get_size(_data))
                    }
        		}
            }
			break
	}
}

#endregion