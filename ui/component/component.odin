package component

Component :: struct {
	// TODO: add id, z index, enabled?
	type:    Component_Type,
	visible: bool,
}

Component_Type :: union {
	Button,
	Label,
}

// `draw` draws the component if visible and executes its function if clicked
draw :: proc(c: ^Component) {
	if !c.visible do return

	switch &type in c.type {
	case Button:
		button_draw(&type)
		if button_is_clicked(&type) && type.execute != nil {
			type.execute()
		}
	case Label:
		label_draw(&type)
	}
}
