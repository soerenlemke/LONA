package game

import scene "scene"
import rl "vendor:raylib"

Game :: struct {
	window:       Game_Window,
	fps:          i32,
	font:         rl.Font,
	active_scene: scene.Scene, // TODO: should hold the active scene -> or better a scene manager knows that info
}

Game_Window :: struct {
	width:    i32,
	height:   i32,
	title:    cstring,
	bg_color: rl.Color,
}

// TODO: move to its own file in scenes package
Scene_Manager :: struct {
	scenes:       [dynamic]scene.Scene,
	active_scene: ^scene.Scene,
}

setup :: proc(app: ^Game) {
	rl.InitWindow(app.window.width, app.window.height, app.window.title)

	app.font = rl.LoadFontEx("unifont.ttf", 20, nil, 0) // TODO: looks like this is not working, do we have to put the file in the repo?

	if app.fps == 0 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}

	scene.scene_init(&app.active_scene)
}

update :: proc(app: ^Game) {
	scene.scene_update(&app.active_scene)
}

draw :: proc(app: ^Game) {
	scene.scene_draw(&app.active_scene, app.font)
}

close :: proc(app: ^Game) {
	scene.scene_destroy(&app.active_scene)
	rl.UnloadFont(app.font)
	rl.CloseWindow()
}
