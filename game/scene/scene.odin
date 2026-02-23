package scene

import "core:log"

GRID_W :: 40
GRID_H :: 20

Grid :: [GRID_H][GRID_W]Tile

// TODO: introduce scene management for switiching between different scenes

Scene :: struct {
	id:     i64,
	active: bool,
	grid:   Grid,
	scenes: [dynamic]Scene,
}

// `scene_init` initializes a scene if it is not active
scene_init :: proc(s: ^Scene) -> (ok: bool) {
	if s.active {
		log.warn("scene_init called on already active scene")
		return false
	}
	s.active = true

	log.debug("scene (%s) initialized successfully", s.id)
	return true
}

// `scene_update` updates the scene and all of its containing scenes recursively if the scene is active itself
scene_update :: proc(s: ^Scene) {
	if !s.active do return

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

// `scene_add_scene` adds a scene to the "scene node" if it the id is unique
scene_add_scene :: proc(s: ^Scene, child: Scene) -> (ok: bool) {
	if scene_id_exists(s, child.id) {
		log.warn("scene_add_scene: scene id %s already exists", child.id)
		return false
	}

	_, err := append_elem(&s.scenes, child)
	if err != nil {
		log.errorf("scene_add_scene: failed to allocate: %v", err)
		return false
	}

	return true
}

scene_remove_scene :: proc(s: ^Scene, remove_id: i64) {
	// TODO: how to quickly go through all scenes? -> also needed ffor scene_add_scene
	// if the scene contains other scenes do we need to remove them recursively?
	if scene_id_exists(s, remove_id) {

	}
}

scene_destroy :: proc(s: ^Scene) {
	// TODO: recursively go through all scenes and cleanup
	s.active = false
}

@(private)
scene_id_exists :: proc(s: ^Scene, id: i64) -> bool {
	if s.id == id do return true

	for &subscene in s.scenes {
		if scene_id_exists(&subscene, id) do return true
	}

	return false
}
