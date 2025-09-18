class_name CharacterOverlay extends Node2D



var character: Character
var color: Color



func _draw() -> void:
	character.button.shape.draw(get_canvas_item(), color)

func show_character_overlay(target_character: Character, highlight_color := Color(1,1,1,0.2)):
	character = target_character
	color = highlight_color
	
	global_position = character.button.global_position
	queue_redraw()
	show()
