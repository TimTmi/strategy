class_name ActionBar extends HBoxContainer



signal decision_made(accepted: bool)



func _on_cancel_pressed() -> void:
	decision_made.emit(false)

func _on_accept_pressed() -> void:
	decision_made.emit(true)
