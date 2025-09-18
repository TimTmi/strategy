extends Button


func _ready():
	grab_focus()

func _on_focus_exited():
	queue_free()

func _on_pressed():
	release_focus()
