extends Resource
class_name InputInstruction


@export var requirements: Array[Callable]

#var input_data

enum InputType {NONE, POSITION, DIRECTION, TARGET, INT}



func get_type() -> InputType:
	return InputType.NONE

func string_to_data(_string: String):
	pass

func data_to_string(_data) -> String:
	return ""

func input_is_valid(_input) -> bool:
	return false

func get_drawing_instruction() -> Array[PositionedShape]:
	return []
