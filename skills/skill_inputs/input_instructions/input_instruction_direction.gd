extends InputInstruction
class_name InputInstructionDirection


var boundary_shape: PositionedShape
var center: Vector2
var radius: int
var start_angle: float = -PI
var end_angle: float = PI


func _init(init_center: Vector2, init_radius: int, init_start_angle: int = 0, init_end_angle: int = 0):
	center = init_center
	radius = init_radius
	if init_start_angle == init_end_angle:
		boundary_shape = ShapeCircle.new(center, 32)
		return
	start_angle = deg_to_rad(init_start_angle)
	end_angle = deg_to_rad(init_end_angle)
	boundary_shape = ShapeArc.new(center, radius, start_angle, end_angle)

func get_type() -> InputType:
	return InputType.DIRECTION

func string_to_data(string: String):
	if string.is_valid_float():
		return deg_to_rad(float(string))
	return null

func data_to_string(data: float):
	return str(round(rad_to_deg(data)))

func get_drawing_instruction() -> Array[PositionedShape]:
	return [boundary_shape]

func input_is_valid(input: float) -> bool:
	return input >= start_angle && input <= end_angle
