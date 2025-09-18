extends PositionedShape
class_name ShapeCircle



func _init(init_position: Vector2, init_radius: int) -> void:
	position = init_position
	shape = CircleShape2D.new()
	shape.radius = init_radius

func has_point(point: Vector2):
	return position.distance_squared_to(point) <= shape.radius * shape.radius
