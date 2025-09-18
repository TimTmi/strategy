class_name MouseInputGetter extends Node2D



#@export_group("Arc")
#@export var arc_quality = 60
#@export var arc_radius = 32
#@export var arc_color: Color = Color(0,0,0.6,0.2)
#
#@export_group("Circle")
#@export var circle_color: Color = Color(0,0,0.6,0.2)

var drawing_instruction: Array[PositionedShape]
var input_zones: Array[InputZone]
var map: Map



signal mouse_clicked(mouse_pos: Vector2)



func _ready() -> void:
	set_process_input(false)

func get_input(new_drawing_instruction: Array[PositionedShape]) -> Vector2:
	drawing_instruction = new_drawing_instruction
	show_input_zones()
	show()
	set_process_input(true)
	return await mouse_clicked

func show_input_zones() -> void:
	for i: int in max(0, drawing_instruction.size() - input_zones.size()):
		var input_zone := InputZone.new()
		input_zones.append(input_zone)
		add_child(input_zone)
	
	for i: int in drawing_instruction.size():
		var input_zone = input_zones[i]
		var shape = drawing_instruction[i]
		input_zone.update(shape)
		input_zone.queue_redraw()
		input_zone.show()

func hide_input_zones() -> void:
	for i: Node2D in input_zones:
		i.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			var mouse_position = get_global_mouse_position()
			if map.has_point(mouse_position):
				for i: PositionedShape in drawing_instruction:
					if i.has_point(mouse_position):
						return_input(mouse_position)
						return
			return_input(Vector2.INF)

func stop_getting_input() -> void:
	set_process_input(false)
	hide_input_zones()
	hide()

func return_input(mouse_position: Vector2) -> void:
	stop_getting_input()
	mouse_clicked.emit(mouse_position)
