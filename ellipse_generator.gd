class_name EllipseGenerator



static func get_ellipse_points(size: Vector2) -> PackedVector2Array:
	var points: PackedVector2Array = []
	var ellipse_resolution: int = _get_ellipse_resolution(size)
	var step: float = TAU / ellipse_resolution
	
	for i in ellipse_resolution:
		points.append(Vector2(cos(i * step) * size.x, sin(i * step) * size.y) * 0.5)
	
	return points

static func _get_ellipse_resolution(ellipse_size: Vector2) -> int:
	ellipse_size /= 2
	var a: int = floori(ellipse_size.x)
	var b: int = floori(ellipse_size.y)
	var h: float = pow(a - b, 2) / pow(a + b, 2)
	var perimeter = PI * (a + b) * (1 + h * 3 / (10 + sqrt(4 - h * 3)))
	return ceil(perimeter)
