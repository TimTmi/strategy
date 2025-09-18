extends Node2D



@export var shadow_a8: int = 130

var shadow_color: Color
var points: PackedVector2Array



func _ready() -> void:
	modulate.a8 = shadow_a8

func _draw() -> void:
	draw_colored_polygon(points, shadow_color)

func get_ellipse_resolution(ellipse_size: Vector2) -> int:
	ellipse_size /= 2
	var a: int = floorf(ellipse_size.x)
	var b: int = floorf(ellipse_size.y)
	var h: float = pow(a - b, 2) / pow(a + b, 2)
	var perimeter = PI * (a + b) * (1 + h * 3 / (10 + sqrt(4 - h * 3)))
	return ceil(perimeter)

func draw_shadow(size: Vector2, color: Color = Color.BLACK):
	shadow_color = color
	var ellipse_resolution: int = get_ellipse_resolution(size)
	var step: float = TAU / ellipse_resolution
	for i in ellipse_resolution:
		points.append(Vector2(cos(i * step) * size.x, sin(i * step) * size.y) * 0.5)
	queue_redraw()
