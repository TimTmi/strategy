extends LineEdit



func _ready() -> void:
	set_process_input(false)

func _on_focus_exited():
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			set_process_input(false)
			text_submitted.emit("")
