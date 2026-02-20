package main

import "core:fmt"
import component "ui/component"
import "ui/renderer"
import rl "vendor:raylib"

window_width :: 1280
window_height :: 720

App :: struct {
	components: [dynamic]component.Component,
}

execute_one :: proc() {
	fmt.printfln("Executed one")
}

execute_two :: proc() {
	fmt.printfln("Executed two")
}

main :: proc() {
	a: App

	rl.InitWindow(window_width, window_height, "Hellope")

	append(
		&a.components,
		component.Component(
			component.Button {
				rect = {100, 100, 250, 50},
				color = rl.BLACK,
				hover_color = rl.LIGHTGRAY,
				label = "Click me!",
				execute = execute_one,
			},
		),
	)

	append(
		&a.components,
		component.Component(
			component.Button {
				rect = {100, 200, 250, 50},
				color = rl.BLACK,
				hover_color = rl.LIGHTGRAY,
				label = "Another button!",
				execute = execute_two,
			},
		),
	)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.GRAY)

		renderer.draw(&a.components)

		rl.EndDrawing()
	}

	delete(a.components)
	rl.CloseWindow()
}
