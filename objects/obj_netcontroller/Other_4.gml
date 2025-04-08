if server > 0
{
	for (var _i = 0; _i < array_length(clients); _i++) {
		if clients[_i].rm == room && _i != sock
		{
			var _plr = instance_create(obj_otherplayer)
			_plr.pid = _i
			_plr.name = clients[_i].name
			client_insts[_i] = _plr.id
		}
	}
}