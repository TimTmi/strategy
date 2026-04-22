class_name Shadow extends Node2D



class ShadowDrawer extends Node2D:
	var _shadow_color: Color
	var _points: PackedVector2Array
	
	
	
	func _init(init_points: PackedVector2Array, init_shadow_color: Color) -> void:
		_points = init_points
		_shadow_color = init_shadow_color
	
	func _draw() -> void:
		draw_colored_polygon(_points, _shadow_color)



@export var shadow_a8: int = 130



func _ready() -> void:
	modulate.a8 = shadow_a8
	z_index = RenderLayers.SHADOWS

func draw_shadow(points: PackedVector2Array, color: Color = Color.BLACK):
	add_child(ShadowDrawer.new(points, color))
