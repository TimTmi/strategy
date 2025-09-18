extends PositionedShape
class_name ShapeArc


var radius: int
var start_angle: int
var end_angle: int

func _init(init_position: Vector2, init_radius: int, init_start_angle: int, init_end_angle: int):
	position = init_position
	radius = init_radius
	start_angle = init_start_angle
	end_angle = init_end_angle

func has_point(point: Vector2) -> bool:
	var displacement := point - position
	var angle = displacement.angle()
	if displacement.length() > radius:
		return false
	if angle < start_angle or angle > end_angle:
		return false
	return true
