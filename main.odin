package main

import "application"
import ui_component "application/ui/component"
import "core:fmt"
import rl "vendor:raylib"

execute_one :: proc() {
	fmt.printfln("Executed one")
}

execute_two :: proc() {
	fmt.printfln("Executed two")
}

main :: proc() {
	app := application.Application {
		window = application.Application_Window {
			width = 1280,
			height = 720,
			title = "Hellope",
			bg_color = rl.BLACK,
		},
		fps = 60,
	}
	application.setup(&app)

	append(
		&app.components,
		ui_component.Component {
			type = ui_component.Label {
				text = "menu",
				pos_x = app.window.width / 2 - 30,
				pos_y = 50,
				font_size = 30,
				color = rl.WHITE,
			},
			visible = true,
		},
	)

	append(
		&app.components,
		ui_component.Component {
			type = ui_component.Button {
				rect = {f32(app.window.width) / 2 - 125, 100, 250, 50},
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
		ui_component.Component {
			type = ui_component.Button {
				rect = {f32(app.window.width) / 2 - 125, 200, 250, 50},
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
		rl.ClearBackground(app.window.bg_color)

		// TODO: a global renderer should draw the active scene
		for &comp in app.components {
			ui_component.draw(&comp)
		}

		rl.EndDrawing()
	}

	application.close(&app)
}
