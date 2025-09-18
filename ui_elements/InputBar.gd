extends LineEdit



#func _ready() -> void:
	#get_viewport().gui_focus_changed.connect(func(node: Control): print(node))

#func _on_text_submitted(_input: String):
	##release_focus()
	#pass

func _on_accept_pressed():
	text_submitted.emit(text)
