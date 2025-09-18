class_name SkillInputPreview extends Node2D



const MARK = preload("res://sprites/target.png")
#const MARK = preload("res://sprites/crosshair.png")

@export var default_color: Color = Color(1,1,1,0.6)
#@export var 



func preview_input_position(input: Vector2) -> void:
	var mark: Sprite2D = Sprite2D.new()
	mark.texture = MARK
	mark.modulate = default_color
	mark.position = input
	add_child(mark)

func preview_input_direction(origin: Vector2, angle: float, radius: int) -> void:
	var line: Line2D = Line2D.new()
	line.width = 1
	line.modulate = default_color
	line.position = origin
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.RIGHT.rotated(angle) * radius)
	add_child(line)
	
	var circle: Circle = Circle.new(radius, default_color)
	circle.position = origin
	add_child(circle)

func stop_preview() -> void:
	for i in get_children():
		i.queue_free()
