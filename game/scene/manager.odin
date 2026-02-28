package scene

Scene_Manager :: struct {
	scenes:       [dynamic]Scene,
	active_scene: ^Scene,
}

// `scene_set_active` sets the active state of the scene
manager_set_active_scene :: proc(m: ^Scene_Manager, id: i64) {
	for &scene in m.scenes {
		if scene.id == id {
			m.active_scene = &scene
		}
	}
}

// `scene_destroy` removes all the scenes subscenes
manager_scene_destroy :: proc(m: ^Scene_Manager) {
	for &subscene, counter in m.scenes {
		unordered_remove(&m.scenes, counter)
	}

	for &scene, counter in m.scenes {
		unordered_remove(&m.scenes, counter)
	}
}

// TODO: how to use scene_add_subscene here? we want to be able to just add scenes or add scenes to a available scene
// `scene_add_scene` adds a scene to the "scene node" if it the id is unique
manager_add_scene :: proc(m: ^Scene_Manager, scene: Scene) -> (ok: bool) {
	if scene_id_exists(m, scene.id) {
		log.warn("scene_add_scene: scene id %s already exists", scene.id)
		return false
	}

	_, err := append_elem(&m.scenes, scene)
	if err != nil {
		log.errorf("scene_add_scene: failed to allocate: %v", err)
		return false
	}

	return true
}


@(private)
scene_id_exists :: proc(m: ^Scene_Manager, id: i64) -> bool {
	for &subscene in m.scenes {
		if subscene.id == id do return true
	}

	return false
}
