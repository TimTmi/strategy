class_name Circle extends Node2D



var radius: int
var color: Color



func _init(init_radius: int, init_color: Color) -> void:
	radius = init_radius
	color = init_color

func _draw() -> void:
	var circle: CircleShape2D = CircleShape2D.new()
	circle.radius = radius
	circle.draw(get_canvas_item(), color)
