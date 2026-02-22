package main

import "core:log"
import "core:os"
import "game"
import rl "vendor:raylib"

main :: proc() {
	logger := log.create_console_logger(log.Level.Debug)
	defer log.destroy_console_logger(logger)
	context.logger = logger

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
