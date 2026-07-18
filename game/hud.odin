package game

import "scene"
import "ui"
import rl "vendor:raylib"

Hud :: struct {
	panel_x:           i32,
	panel_width:       i32,
	panel_height:      i32,

	// cyclic updated values
	energy_bar:        ui.Progress_Bar,
	clean_bar:         ui.Progress_Bar,
	plant_bar:         ui.Progress_Bar,
	systems_bar:       ui.Progress_Bar,

	// static elements like title, buttons, etc.
	static_components: [dynamic]ui.Component,
}

hud_init :: proc(app: ^Game) -> Hud {
	h: Hud
	h.panel_x = scene.GRID_W * scene.CELL_SIZE
	h.panel_width = UI_PANEL_WIDTH
	h.panel_height = app.window.height

	bar_x := f32(h.panel_x) + 10
	bar_w := f32(h.panel_width) - 20

	h.energy_bar = ui.Progress_Bar {
		rect       = {bar_x, 40, bar_w, 16},
		value      = 1.0,
		fill_color = rl.Color{64, 192, 96, 255},
		bg_color   = rl.Color{30, 40, 45, 255},
	}

	h.clean_bar = ui.Progress_Bar {
		rect       = {bar_x, 70, bar_w, 16},
		value      = 0.3,
		fill_color = rl.Color{255, 160, 40, 255},
		bg_color   = rl.Color{30, 40, 45, 255},
	}

	h.plant_bar = ui.Progress_Bar {
		rect       = {bar_x, 100, bar_w, 16},
		value      = 0.3,
		fill_color = rl.Color{100, 160, 40, 255},
		bg_color   = rl.Color{30, 40, 45, 255},
	}

	h.systems_bar = ui.Progress_Bar {
		rect       = {bar_x, 100, bar_w, 16},
		value      = 0.3,
		fill_color = rl.Color{240, 50, 40, 255},
		bg_color   = rl.Color{30, 40, 45, 255},
	}

	h.static_components = make([dynamic]ui.Component)
	append(
		&h.static_components,
		ui.Component {
			visible = true,
			type = ui.Label {
				text = "ROBOTER STATUS",
				pos_x = h.panel_x + 10,
				pos_y = 10,
				font_size = 18,
				color = rl.Color{80, 96, 112, 255},
			},
		},
	)

	return h
}

hud_update :: proc(h: ^Hud, app: ^Game) {
	// TODO: update the cyclic updated bars
}

hud_draw :: proc(h: ^Hud) {
	rl.DrawRectangle(
		h.panel_x,
		0,
		h.panel_width,
		h.panel_height,
		rl.Color{15, 15, 20, 255},
	)

	rl.DrawRectangleLines(
		h.panel_x,
		0,
		h.panel_width,
		h.panel_height,
		rl.Color{60, 70, 80, 255},
	)

	for &c in h.static_components {
		ui.draw(&c)
	}

	ui.progress_bar_draw(&h.energy_bar)
	ui.progress_bar_draw(&h.clean_bar)
	ui.progress_bar_draw(&h.plant_bar)
	ui.progress_bar_draw(&h.systems_bar)
}

hud_destroy :: proc(h: ^Hud) {
	delete(h.static_components)
}
