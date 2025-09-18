class_name DrawingInstruction extends Resource



var position: Vector2
var shape: Shape2D



func _init(init_position: Vector2, init_shape: Shape2D):
	position = init_position
	shape = init_shape
