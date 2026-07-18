package ui

import rl "vendor:raylib"

Progress_Bar :: struct {
	rect:       rl.Rectangle,
	value:      f32, // 0.0 - 1.0
	fill_color: rl.Color,
	bg_color:   rl.Color,
}

progress_bar_draw :: proc(p: ^Progress_Bar) {
	rl.DrawRectangleRec(p.rect, p.bg_color)

	fill_width := p.rect.width * clamp(p.value, 0, 1)
	fill_rect := rl.Rectangle{p.rect.x, p.rect.y, fill_width, p.rect.height}
	rl.DrawRectangleRec(fill_rect, p.fill_color)
}
