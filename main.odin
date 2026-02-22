package main

import "game"
import rl "vendor:raylib"

main :: proc() {
	app := game.Game {
		window = game.Game_Window {
			width = 1280,
			height = 720,
			title = "LONA",
			bg_color = rl.BLACK,
		},
		fps = 60,
	}

	game.setup(&app)
	defer game.close(&app)

	for !rl.WindowShouldClose() {

		game.update(&app)

		rl.BeginDrawing()
		rl.ClearBackground(app.window.bg_color)
		game.draw(&app)
		rl.EndDrawing()
	}
}
