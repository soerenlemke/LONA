package game

import scene "scene"
import rl "vendor:raylib"

Game :: struct {
	window: Game_Window,
	fps:    i32,
	font:   rl.Font,
	scene:  scene.Scene, // TODO: should hold the active scene
}

Game_Window :: struct {
	width:    i32,
	height:   i32,
	title:    cstring,
	bg_color: rl.Color,
}

setup :: proc(app: ^Game) {
	rl.InitWindow(app.window.width, app.window.height, app.window.title)

	app.font = rl.LoadFontEx("unifont.ttf", 20, nil, 0)

	if app.fps == 0 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}

	scene.scene_init(&app.scene)
}

update :: proc(app: ^Game) {
	scene.scene_update(&app.scene)
}

draw :: proc(app: ^Game) {
	scene.scene_draw(&app.scene, app.font)
}

close :: proc(app: ^Game) {
	scene.scene_destroy(&app.scene)
	rl.UnloadFont(app.font)
	rl.CloseWindow()
}
