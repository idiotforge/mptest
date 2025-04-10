var _v = keyboard_check(vk_down) - keyboard_check(vk_up)
var _h = keyboard_check(vk_right) - keyboard_check(vk_left)

x += _h * 3
y += _v * 3

if keyboard_check_pressed(vk_control)
    if room == rm_test
        room_goto(rm_test2)
    else {
    	room_goto(rm_test)
    }