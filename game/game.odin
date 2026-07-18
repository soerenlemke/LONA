package game

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
	rl.InitWindow(app.window.width, app.window.height, app.window.title)
	font_path := cstring("game/assets/unifont-16.0.04.ttf")
	app.font = rl.LoadFontEx(font_path, 20, nil, 0)

	if app.fps <= 60 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}

	initial_scene := scene.Scene {
		id = 0,
	}
	scene.manager_add_scene(&app.scene_manager, initial_scene)
	scene.manager_set_active_scene(&app.scene_manager, 0)
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
