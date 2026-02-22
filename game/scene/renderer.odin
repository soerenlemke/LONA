package scene

import rl "vendor:raylib"

CELL_WIDTH :: 18
CELL_HEIGHT :: 20

scene_draw :: proc(s: ^Scene, font: rl.Font) {
	if !s.active do return

	for row in 0 ..< GRID_H {
		for col in 0 ..< GRID_W {
			tile := s.grid[row][col]

			if !tile.visible do continue

			vis := TILE_VISUALS[tile.type]
			x := i32(col) * CELL_WIDTH
			y := i32(row) * CELL_HEIGHT

			rl.DrawRectangle(x, y, CELL_WIDTH, CELL_HEIGHT, vis.background)

			buf := glyph_to_cstring(vis.glyph)
			rl.DrawTextEx(
				font,
				cstring(&buf[0]),
				{f32(x), f32(y)},
				f32(CELL_HEIGHT),
				0,
				vis.foreground,
			)
		}
	}
}

@(private)
glyph_to_cstring :: proc(r: rune) -> [5]byte {
	buf: [5]byte
	switch {
	case r < 0x80:
		buf[0] = byte(r)
	case r < 0x800:
		buf[0] = byte(0xC0 | (r >> 6))
		buf[1] = byte(0x80 | (r & 0x3F))
	case r < 0x10000:
		buf[0] = byte(0xE0 | (r >> 12))
		buf[1] = byte(0x80 | ((r >> 6) & 0x3F))
		buf[2] = byte(0x80 | (r & 0x3F))
	case:
		buf[0] = byte(0xF0 | (r >> 18))
		buf[1] = byte(0x80 | ((r >> 12) & 0x3F))
		buf[2] = byte(0x80 | ((r >> 6) & 0x3F))
		buf[3] = byte(0x80 | (r & 0x3F))
	}
	return buf
}
