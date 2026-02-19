package renderer

import component "../component"

Renderer :: struct {
	components: [dynamic]component.Component,
}

add :: proc(r: ^Renderer, c: component.Component) {
	append(&r.components, c)
}

draw :: proc(r: ^Renderer) {
	for &comp in r.components {
		component.draw(&comp)
	}
}

// TODO: clicking should connect specified functions for each component
is_clicked :: proc(r: ^Renderer) -> bool {
	for &comp in r.components {
		if component.is_clicked(&comp) do return true
	}
	return false
}

destroy :: proc(r: ^Renderer) {
	delete(r.components)
}
