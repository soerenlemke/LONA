package main

import component "ui/component"
import "ui/renderer"
import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

main :: proc() {
	rl.InitWindow(window_width, window_height, "Hellope")

	r: renderer.Renderer

	renderer.add(
		&r,
		component.Component(
			component.Button {
				rect = {100, 100, 250, 50},
				color = rl.BLACK,
				hover_color = rl.LIGHTGRAY,
				label = "Click me!",
			},
		),
	)

	renderer.add(
		&r,
		component.Component(
			component.Button {
				rect = {100, 200, 250, 50},
				color = rl.BLACK,
				hover_color = rl.LIGHTGRAY,
				label = "Another button!",
			},
		),
	)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.GRAY)

		renderer.draw(&r)

		// TODO: clicking should execute attached functions
		if renderer.is_clicked(&r) {
			break
		}

		rl.EndDrawing()
	}

	renderer.destroy(&r)
	rl.CloseWindow()
}
