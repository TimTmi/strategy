class_name InputZone extends Node2D



var shape: Shape2D
var color: Color



func _draw() -> void:
	shape.draw(get_canvas_item(), color)

func update(positioned_shape: PositionedShape, init_color: Color = Color(0.3,0.3,0.6,0.2)) -> void:
	position = positioned_shape.position
	shape = positioned_shape.shape
	color = init_color
