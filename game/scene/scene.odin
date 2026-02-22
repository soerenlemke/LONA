package scene

GRID_W :: 40
GRID_H :: 20

Grid :: [GRID_H][GRID_W]Tile

// TODO: introduce scene management for switiching between different scenes

Scene :: struct {
	active: bool,
	grid:   Grid,
}

scene_init :: proc(s: ^Scene) {
	s.active = true

	// example room
	for row in 0 ..< GRID_H {
		for col in 0 ..< GRID_W {
			is_border :=
				row == 0 || row == GRID_H - 1 || col == 0 || col == GRID_W - 1
			s.grid[row][col] = {
				type    = .Wall if is_border else .Floor,
				visible = true,
			}
		}
	}

	// place objects as an example for now
	s.grid[3][3].type = .Plant_Medium
	s.grid[3][4].type = .Plant_Small
	s.grid[5][8].type = .Machine_Ok
	s.grid[5][9].type = .Machine_Broken
	s.grid[8][6].type = .Dirt_Light
	s.grid[8][7].type = .Dirt_Heavy
	s.grid[10][15].type = .Charge_Station
	s.grid[4][20].type = .Water_Leak
	s.grid[6][15].type = .Robot
}

scene_update :: proc(s: ^Scene) {
	if !s.active do return

	// game logic is updated here:
	// - dirt over time
	// - robot moving
	// - machine states getting worse
	for row in 0 ..< GRID_H {
		for col in 0 ..< GRID_W {
			_ = &s.grid[row][col]
		}
	}
}

scene_destroy :: proc(s: ^Scene) {
	s.active = false
}
