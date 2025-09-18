extends InputInstruction
class_name InputInstructionTarget


var boundary_shape: PositionedShape
var targets: Array[Character]


func _init(init_shape: PositionedShape = null, init_requirements: Array[Callable] = []):
	boundary_shape = init_shape
	if init_requirements:
		return

func get_type() -> InputType:
	return InputType.TARGET

func string_to_data(string: String):
	for i in targets:
		if i.name == string:
			return i
	return null

func data_to_string(data: Node):
	return data.name

func get_drawing_instruction() -> Array[PositionedShape]:
	return [boundary_shape]

func input_is_valid(input: Character) -> bool:
	return input in targets
