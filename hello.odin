package main

import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

color_light_blue :: rl.Color{160, 200, 255, 255}

main :: proc() {
	rl.InitWindow(window_width, window_height, "Hellope")

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		button := rl.Rectangle{100, 100, 250, 50}
		rl.DrawRectangle(
			cast(i32)button.x,
			cast(i32)button.y,
			cast(i32)button.width,
			cast(i32)button.height,
			rl.BLACK,
		)
		if rl.CheckCollisionPointRec(rl.GetMousePosition(), button) {
			return
		}

		rl.ClearBackground(color_light_blue)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
