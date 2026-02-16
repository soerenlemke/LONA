package main

import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

color_light_blue :: rl.Color{160, 200, 255, 255}

main :: proc() {
	rl.InitWindow(window_width, window_height, "Hellope")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(color_light_blue)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
