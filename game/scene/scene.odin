package scene

import "core:log"

GRID_W :: 40
GRID_H :: 20

Grid :: [GRID_H][GRID_W]Tile

Scene :: struct {
	id:     i64,
	grid:   Grid,
	scenes: [dynamic]Scene,
}

// `scene_update` updates the scene and all of its containing scenes recursively if the scene is active itself
scene_update :: proc(s: ^Scene) {
	// logic for the current scene
	for row in 0 ..< GRID_H {
		for col in 0 ..< GRID_W {
			_ = &s.grid[row][col]
			// TODO: add more stuff -> tile := &s.grid[row][col]
			// - dirt over time
			// - robot moving
			// - machine states getting worse
		}
	}

	// recursively update all scenes
	for &subscene in s.scenes {
		scene_update(&subscene)
	}
}

scene_add_subscene :: proc(s: ^Scene, subscene: Scene) -> bool {
	_, err := append_elem(&s.scenes, subscene)
	if err != nil {
		log.errorf("scene_add_scene: failed to allocate: %v", err)
		return false
	}

	return true
}
