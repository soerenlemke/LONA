package component

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
	rl.DrawText(b.label, i32(b.rect.x + 10), i32(b.rect.y + 15), 20, rl.WHITE)
}

button_is_clicked :: proc(b: ^Button) -> bool {
	return(
		rl.CheckCollisionPointRec(rl.GetMousePosition(), b.rect) &&
		rl.IsMouseButtonPressed(.LEFT) \
	)
}
