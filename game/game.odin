package game

import "core:log"
import "scene"
import rl "vendor:raylib"

Game :: struct {
	window:        Game_Window,
	fps:           i32,
	font:          rl.Font,
	scene_manager: scene.Scene_Manager,
	hud:           Hud,
}

Game_Window :: struct {
	width:    i32,
	height:   i32,
	title:    cstring,
	bg_color: rl.Color,
}

// game area panel (3:1 -> game left, menu right)
UI_PANEL_WIDTH :: (scene.GRID_W * scene.CELL_SIZE) / 3

setup :: proc(app: ^Game) {
	scene.init_char_to_tile()

	// sizing the main screen to always have the same
	// ratio of game are and menu
	game_area_width := scene.GRID_W * scene.CELL_SIZE
	game_area_height := scene.GRID_H * scene.CELL_SIZE
	app.window.width = i32(game_area_width + UI_PANEL_WIDTH)
	app.window.height = i32(game_area_height)

	rl.InitWindow(app.window.width, app.window.height, app.window.title)
	set_fps(app, 60)
	load_font(app, "game/assets/unifont-16.0.04.ttf")

	room_1, ok := scene.load_map_from_mapfile("game/assets/maps/room_1.map", 1)
	if !ok {
		log.error("setup: failed to load room_1, falling back to empty scene")
		room_1 = scene.Scene {
			id = 1,
		}
	}

	scene.manager_add_scene(&app.scene_manager, room_1)
	scene.manager_set_active_scene(&app.scene_manager, 1)

	app.hud = hud_init(app)
}

update :: proc(app: ^Game) {
	scene.scene_update(app.scene_manager.active_scene)
	hud_update(&app.hud, app)
}

draw :: proc(app: ^Game) {
	scene.scene_draw(app.scene_manager.active_scene, app.font)
	hud_draw(&app.hud)
}

close :: proc(app: ^Game) {
	hud_destroy(&app.hud)
	scene.manager_scene_destroy(&app.scene_manager)
	rl.UnloadFont(app.font)
	rl.CloseWindow()
}

@(private)
set_fps :: proc(app: ^Game, fps: i32) {
	if app.fps <= 60 {
		rl.SetTargetFPS(60)
	} else {
		rl.SetTargetFPS(app.fps)
	}
}

@(private)
load_font :: proc(app: ^Game, font_path: string) {
	// codepoints from all tile glyphs so the font contains all used unicode signs
	codepoints := make([dynamic]rune)
	defer delete(codepoints)
	for tile_type in scene.Tile_Type {
		visual := scene.TILE_VISUALS[tile_type]
		append(&codepoints, visual.glyph)
	}

	font_path_cstring := cstring(raw_data(font_path))

	app.font = rl.LoadFontEx(
		font_path_cstring,
		20,
		raw_data(codepoints[:]),
		i32(len(codepoints)),
	)
}
