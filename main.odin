package main

import "core:fmt"
import component "ui/component"
import "ui/renderer"
import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

App :: struct {
	bg_color:   rl.Color,
	components: [dynamic]component.Component,
}

execute_one :: proc() {
	fmt.printfln("Executed one")
}

execute_two :: proc() {
	fmt.printfln("Executed two")
}

main :: proc() {
	app: App
	app.bg_color = rl.BLACK

	rl.InitWindow(window_width, window_height, "Hellope")

	append(
		&app.components,
		component.Component {
			type = component.Label {
				text = "menu",
				pos_x = window_width / 2 - 30,
				pos_y = 50,
				font_size = 30,
				color = rl.WHITE,
			},
			visible = true,
		},
	)

	append(
		&app.components,
		component.Component {
			type = component.Button {
				rect = {window_width / 2 - 125, 100, 250, 50},
				color = rl.GRAY,
				hover_color = rl.LIGHTGRAY,
				label = "Click me!",
				execute = execute_one,
			},
			visible = true,
		},
	)

	append(
		&app.components,
		component.Component {
			type = component.Button {
				rect = {window_width / 2 - 125, 200, 250, 50},
				color = rl.GRAY,
				hover_color = rl.LIGHTGRAY,
				label = "Another button!",
				execute = execute_two,
			},
			visible = true,
		},
	)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(app.bg_color)

		renderer.draw(&app.components)

		rl.EndDrawing()
	}

	delete(app.components)
	rl.CloseWindow()
}
