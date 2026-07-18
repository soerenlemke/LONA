package scene

import "core:log"
import "core:os"
import "core:strings"

// TODO: Fallback when loading error

load_map_from_mapfile :: proc(
	file_path: string,
	id: i64,
) -> (
	s: Scene,
	ok: bool,
) {
	data, err := os.read_entire_file_from_path(file_path, context.allocator)
	if err != nil {
		log.errorf(
			"load_map_from_mapfile: couldn't read file: %s (%v)",
			file_path,
			err,
		)
		return {}, false
	}
	defer delete(data)

	s.id = id

	text := string(data)
	it := text
	row := 0

	for line in strings.split_lines_iterator(&it) {
		if row >= GRID_H {
			log.warnf(
				"load_map_from_mapfile: map has more rows than GRID_H (%d), truncating",
				GRID_H,
			)
			break
		}

		clean_line := strings.trim_right(line, "\r")

		col := 0
		for r in clean_line {
			if col >= GRID_W {
				log.warnf(
					"load_map_from_mapfile: row %d has more columns than GRID_W (%d), truncating",
					row,
					GRID_W,
				)
				break
			}

			tile_type, found := CHAR_TO_TILE[r]
			if !found {
				log.warnf(
					"load_map_from_mapfile: unknown glyph '%v' at row %d col %d, defaulting to Empty",
					r,
					row,
					col,
				)
				tile_type = .Empty
			}

			s.grid[row][col] = Tile {
				type    = tile_type,
				visible = true,
			}
			col += 1
		}

		row += 1
	}

	if row < GRID_H {
		log.warnf(
			"load_map_from_mapfile: map only had %d rows, expected %d; remaining rows left empty",
			row,
			GRID_H,
		)
	}

	return s, true
}
