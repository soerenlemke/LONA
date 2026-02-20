package component

Component :: union {
	Button,
}

// `draw` draws the component and executes its function if clicked
draw :: proc(c: ^Component) {
	switch &val in c {
	case Button:
		button_draw(&val)
		if button_is_clicked(&val) && val.execute != nil {
			val.execute()
		}
	}
}
