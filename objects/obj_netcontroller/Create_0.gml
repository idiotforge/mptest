randomize()
enum messages {
	playerjoin, // you give the server your name
	playerinit, // server assigns you an id
	playerdata // player data
}
server = -1
is_server = false
maxclients = 16
clients = array_create(maxclients)
client_insts = array_create(maxclients)
port = 25565 //love the minecraft port gahhhhhh
ip = "127.0.0.1"
name_entry = "hesrightyouknow"
sock = 0
function trace()
{
	var r = string(argument[0]), i;
	for (i = 1; i < argument_count; i++) {
	    r += ", " + string(argument[i])
	}
	show_debug_message(r)
}
