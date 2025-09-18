extends Button


var drawing_instruction: DrawingInstruction

func _draw():
	callv(drawing_instruction.method, drawing_instruction.arguments)
	#draw_circle(Vector2.ZERO, 32, Color.WHITE)

func get_input(instruction: DrawingInstruction):
	drawing_instruction = instruction
	queue_redraw()
	show()

func _on_pressed():
	hide()
