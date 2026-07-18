package game

import "core:log"
import scene "scene"
import rl "vendor:raylib"

Game :: struct {
	window:        Game_Window,
	fps:           i32,
	font:          rl.Font,
	scene_manager: scene.Scene_Manager,
}

Game_Window :: struct {
	width:    i32,
	height:   i32,
	title:    cstring,
	bg_color: rl.Color,
}

setup :: proc(app: ^Game) {
	app.window.width = scene.GRID_W * scene.CELL_SIZE
	app.window.height = scene.GRID_H * scene.CELL_SIZE

	rl.InitWindow(app.window.width, app.window.height, app.window.title)
	font_path := cstring("game/assets/unifont-16.0.04.ttf")
	app.font = rl.LoadFontEx(font_path, 20, nil, 0)

	if app.fps <= 60 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}

	scene.init_char_to_tile()

	room_1, ok := scene.load_map_from_mapfile("game/assets/maps/room_1.map", 1)
	if !ok {
		log.error("setup: failed to load room_1, falling back to empty scene")
		room_1 = scene.Scene {
			id = 1,
		}
	}

	scene.manager_add_scene(&app.scene_manager, room_1)
	scene.manager_set_active_scene(&app.scene_manager, 1)
}

update :: proc(app: ^Game) {
	scene.scene_update(app.scene_manager.active_scene)
}

draw :: proc(app: ^Game) {
	scene.scene_draw(app.scene_manager.active_scene, app.font)
}

close :: proc(app: ^Game) {
	scene.manager_scene_destroy(&app.scene_manager)
	rl.UnloadFont(app.font)
	rl.CloseWindow()
}
