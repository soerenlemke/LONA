package ui

import rl "vendor:raylib"

Label :: struct {
	text:      cstring,
	pos_x:     i32,
	pos_y:     i32,
	font_size: i32,
	color:     rl.Color,
}

label_draw :: proc(l: ^Label) {
	rl.DrawText(l.text, l.pos_x, l.pos_y, l.font_size, l.color)
}
