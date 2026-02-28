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

	app.font = rl.LoadFontEx("unifont.ttf", 20, nil, 0) // TODO: looks like this is not working, do we have to put the file in the repo?

	if app.fps == 0 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}
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
