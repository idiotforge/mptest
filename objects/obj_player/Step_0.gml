var _v = keyboard_check(vk_down) - keyboard_check(vk_up)
var _h = keyboard_check(vk_right) - keyboard_check(vk_left)

if _h != 0 || _v != 0 {
    sprite_index = spr_player_walk
} else {
    sprite_index = spr_player_idle
}

if _h != 0 {
    image_xscale = _h
}

x += _h * 2
y += _v * 2

if keyboard_check_pressed(vk_control) {
    if room == rm_test
        room_goto(rm_test2)
    else {
    	room_goto(rm_test)
    }
}