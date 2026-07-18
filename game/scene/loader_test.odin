package scene

import "core:log"
import "core:testing"

@(test)
test_load_map_from_mapfile :: proc(t: ^testing.T) {
	init_char_to_tile()

	s, ok := load_map_from_mapfile("game/assets/maps/room_1.map", 1)
	testing.expect(t, ok, "expected map to load successfully")
	testing.expect(t, s.id == 1, "expected scene id to be 1")
	testing.expect(
		t,
		s.grid[0][0].type == .Wall,
		"expected top-left tile to be a wall",
	)
	testing.expect(
		t,
		s.grid[6][12].type == .Robot,
		"expected robot at row 6, col 8",
	)
	log.infof("loaded scene: id=%d", s.id)
}
