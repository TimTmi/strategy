extends InputInstruction
class_name InputInstructionPosition


var boundary_shape: PositionedShape


func _init(shape: PositionedShape = null):
	boundary_shape = shape

func get_type() -> InputType:
	return InputType.POSITION

func string_to_data(string: String):
	var values: PackedStringArray = string.split(",")
	if values.size() != 2:
		return null
	for value in values:
		if not value.is_valid_float():
			return null
	return Vector2(int(values[0]), int(values[1]))

func data_to_string(data: Vector2):
	return "%s,%s" %[data.x, data.y]

func get_drawing_instruction() -> Array[PositionedShape]:
	return [boundary_shape]

func input_is_valid(input: Vector2) -> bool:
	return boundary_shape.has_point(input)
