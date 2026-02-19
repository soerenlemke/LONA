package component

Component :: union {
	Button,
}

draw :: proc(c: ^Component) {
	switch &val in c {
	case Button:
		button_draw(&val)
	}
}

is_clicked :: proc(c: ^Component) -> bool {
	switch &val in c {
	case Button:
		return button_is_clicked(&val)
	}
	return false
}
