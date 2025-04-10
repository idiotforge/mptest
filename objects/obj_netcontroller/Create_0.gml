/* 
 * idk what im doing
 * this NEEDS a rewrite
 *     - idiotforge
 */

enum messages {
	playerjoin, // you give the server your name
	playerinit, // server assigns you an id
    updateclients, // updates the clients array
	playerdata // player data
}
server = -1
is_server = false
maxclients = 16
clients = array_create(maxclients) // my perfect solution to clients ids
client_insts = array_create(maxclients)
port = 25565 //love the minecraft port gahhhhhh
ip = "127.0.0.1"
name_entry = random_name()
sock = 0
menu = false
function trace() {
	var r = string(argument[0]), i;
	for (i = 1; i < argument_count; i++) {
	    r += ", " + string(argument[i])
	}
	show_debug_message(r)
}
function random_name() {
    randomize()
    var _name = choose(
    "Bart", "Peter", "Luigi", "Mario", "Waluigi", "Wario", "Toad", "John", "Garfield", "Steve", "Chicken", "KFC",
    "kenan", "Albert", "Jason", "Josh", "Peppino", "Noise", "The", "Scout", "Engineer", "Medic", "Simple",
    "Meteor", "Gamer", "Real", "Gabe", "Flint", "Stupid", "Junpei", "IWannaBeThe", "Sonic", "Knuckles", "Miles",
    "Brandy", "Dr", "Mc", "Mr", "PizzaTower", "Scott", "Jay", "Bean", "Baldi", "Diddy", "Donkey", "Oppan", "Hideo",
    "Tralalelo", "Gassy", "Big", "Ender", "Kiryu", "Mushroom", "Lario", "Motha", "Eggman"
    )
    if _name == "kenan"
        return "kenan238"
    if _name != "The" && _name != "IWannaBeThe" {
        if irandom(3) == 3 { // 1/4 chance 
            _name += "The"
        }
    }
    _name += choose("Simpson", "Griffin", "Mario", "Pork", "Johnson", "Ward", "Jockey",
    "Fan", "Pepperman", "Idiot", "Einstein", "Momoa","Shedletsky", "Spaghetti", "Theodore",
    "Flips", "Dist", "Beer", "Gaming", "Pizza", "TT", "_", "Wii", "U", "Cena", "Bringus", "Studios",
    "Steel", "Newell", "Iori", "Guy", "Hedgehog", "Echidna", "Prower", "Bro", "Pig", "Leno", "NoiseHair",
    "Kong", "Gangnam", "Kojima", "Game", "Tralala", "Unc", "Hero", "Chungus", "Cat", "Pearl", "Kazuma",
    "Rizztein", "Outlet", "Fucka"
    )
    for (var _c = irandom_range(2, 5); _c > 0; _c--) {
        _name += string(irandom(9))
    }
    return _name
}
