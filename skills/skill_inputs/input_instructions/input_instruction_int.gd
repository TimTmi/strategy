extends InputInstruction
class_name InputInstructionInt



var min_value := -9223372036854775808
var max_value := 9223372036854775807



func _init(init_min_value := -9223372036854775808, init_max_value := 9223372036854775807, init_requirements: Array[Callable] = []) -> void:
	if init_min_value > init_max_value:
		var temp := init_min_value
		init_min_value = init_max_value
		init_max_value = temp
	min_value = init_min_value
	max_value = init_max_value
	requirements = init_requirements

func get_type() -> InputType:
	return InputType.INT

func string_to_data(string: String):
	if not string.is_valid_int():
		return null
	var value := int(string)
	if input_is_valid(value):
		return value
	return null

func data_to_string(data: int) -> String:
	return str(data)

func input_is_valid(input: int) -> bool:
	if input < min_value or input > max_value:
		return false
	for i: Callable in requirements:
		if i.call(input) == false:
			return false
	return true
