package main

import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

main :: proc() {
	rl.InitWindow(window_width, window_height, "Hellope")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground({160, 200, 255, 255})
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
