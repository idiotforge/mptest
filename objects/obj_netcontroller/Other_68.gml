var _type = async_load[? "type"]

// Connected
if (_type == network_type_connect) {
	var _sock = async_load[? "socket"]
	trace("socket:  " + string(_sock))
	trace("server: " + string(server))
	// Send player info
	var _buffer = buffer_create(2, buffer_grow, 1)
	buffer_write(_buffer, buffer_u8, messages.playerinit)
    clients[_sock] = {
		name: "noname",
		rm: string(rm_init)
	}
	buffer_write(_buffer, buffer_string, json_stringify(clients))
    buffer_write(_buffer, buffer_u8, _sock)
	network_send_raw(_sock, _buffer, buffer_get_size(_buffer))
	buffer_delete(_buffer)
}
// Data
else if (_type == network_type_data) {
	var _buffer = async_load[? "buffer"]
	var _sock = async_load[? "id"]
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	var _data = buffer_read(_buffer, buffer_u8)
	
	switch _data
	{
		// client-side
		case messages.playerinit:
			sock = buffer_read(_buffer, buffer_u8)
            clients = json_parse(buffer_read(_buffer, buffer_string))
			_data = buffer_create(1, buffer_grow, 1)
			buffer_write(_data, buffer_u8, messages.playerjoin)
			buffer_write(_data, buffer_string, name_entry)
			network_send_raw(server, _data, buffer_get_size(_data))
			break;
		// server-side
		case messages.playerjoin:
			clients[_sock].name = buffer_read(_buffer, buffer_string)
            trace(clients[_sock].name + " joined on socket " + string(_sock))
            var _plr = instance_create(obj_otherplayer)
			_plr.pid = _sock
			_plr.name = clients[_sock].name
			client_insts[_sock] = _plr.id
			break;
		// both server and clientside
		case messages.playerdata:
			client_insts[_sock].x = buffer_read(_buffer, buffer_f16)
			client_insts[_sock].y = buffer_read(_buffer, buffer_f16)
			clients[_sock].rm = buffer_read(_buffer, buffer_string)
			break
	}
}