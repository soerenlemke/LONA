package ui

import rl "vendor:raylib"

Button :: struct {
	rect:        rl.Rectangle,
	color:       rl.Color,
	hover_color: rl.Color,
	label:       cstring,
	execute:     proc(),
}

button_draw :: proc(b: ^Button) {
	color := b.color
	if rl.CheckCollisionPointRec(rl.GetMousePosition(), b.rect) {
		color = b.hover_color
	}
	rl.DrawRectangleRec(b.rect, color)

	// TODO: center text inside buttons
	len := len(b.label)
	x_pos := b.rect.x + b.rect.width / 2 - f32(len) / 2

	// (text: cstring, posX, posY: c.int, fontSize: c.int, color: Color)
	rl.DrawText(b.label, i32(x_pos), i32(b.rect.y + 15), 20, rl.WHITE)
}

button_is_clicked :: proc(b: ^Button) -> bool {
	return(
		rl.CheckCollisionPointRec(rl.GetMousePosition(), b.rect) &&
		rl.IsMouseButtonPressed(.LEFT) \
	)
}
