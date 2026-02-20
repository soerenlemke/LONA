package renderer

import component "../component"

draw :: proc(components: ^[dynamic]component.Component) {
	for &comp in components {
		component.draw(&comp)
	}
}
