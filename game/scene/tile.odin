package scene

import rl "vendor:raylib"

Tile :: struct {
	type:    Tile_Type,
	visible: bool,
}

Tile_Type :: enum {
	Empty,

	// structures
	Wall,
	Floor,
	Door_Open,
	Door_Closed,

	// robot
	Robot,
	Charge_Station,

	// dirt
	Dirt_Light,
	Dirt_Heavy,
	Water_Leak,

	// plants
	Plant_Small,
	Plant_Medium,
	Plant_Large,
	Plant_Dead,

	// machines
	Machine_Ok,
	Machine_Damaged,
	Machine_Broken,

	// energy & water
	Energy_Node,
	Energy_Pickup,
	Water_Pipe,
	Water_Source,
}

Tile_Visual :: struct {
	glyph:      rune,
	foreground: rl.Color,
	background: rl.Color,
}

// colors
@(private)
_BLACK :: rl.Color{10, 10, 15, 255}
@(private)
_WALL :: rl.Color{74, 90, 106, 255}
@(private)
_FLOOR :: rl.Color{30, 46, 62, 255}
@(private)
_ROBOT :: rl.Color{96, 208, 255, 255}
@(private)
_DIRT :: rl.Color{139, 94, 60, 255}
@(private)
_DIRT_DARK :: rl.Color{100, 60, 30, 255}
@(private)
_PLANT :: rl.Color{58, 138, 58, 255}
@(private)
_PLANT_DEAD :: rl.Color{100, 80, 40, 255}
@(private)
_MACHINE :: rl.Color{112, 136, 152, 255}
@(private)
_DAMAGED :: rl.Color{255, 160, 40, 255}
@(private)
_BROKEN :: rl.Color{255, 64, 64, 255}
@(private)
_ENERGY :: rl.Color{255, 208, 96, 255}
@(private)
_WATER :: rl.Color{32, 96, 192, 255}
@(private)
_CHARGE :: rl.Color{64, 255, 144, 255}
@(private)
_DOOR :: rl.Color{160, 112, 64, 255}

// lookup table: Tile_Type -> Tile_Visual
TILE_VISUALS := [Tile_Type]Tile_Visual {
	.Empty           = {' ', _BLACK, _BLACK},
	.Wall            = {'█', _WALL, _BLACK},
	.Floor           = {'·', _FLOOR, _BLACK},
	.Door_Open       = {'░', _DOOR, _BLACK},
	.Door_Closed     = {'▓', _DOOR, _BLACK},
	.Robot           = {'@', _ROBOT, _BLACK},
	.Charge_Station  = {'⌂', _CHARGE, _BLACK},
	.Dirt_Light      = {'%', _DIRT, _BLACK},
	.Dirt_Heavy      = {'%', _DIRT_DARK, _BLACK},
	.Water_Leak      = {'≈', _WATER, _BLACK},
	.Plant_Small     = {'♦', _PLANT, _BLACK},
	.Plant_Medium    = {'♣', _PLANT, _BLACK},
	.Plant_Large     = {'♠', _PLANT, _BLACK},
	.Plant_Dead      = {'†', _PLANT_DEAD, _BLACK},
	.Machine_Ok      = {'▣', _MACHINE, _BLACK},
	.Machine_Damaged = {'▣', _DAMAGED, _BLACK},
	.Machine_Broken  = {'▣', _BROKEN, _BLACK},
	.Energy_Node     = {'¤', _ENERGY, _BLACK},
	.Energy_Pickup   = {'$', _ENERGY, _BLACK},
	.Water_Pipe      = {'┼', _WATER, _BLACK},
	.Water_Source    = {'○', _WATER, _BLACK},
}
