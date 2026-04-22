class_name Bow extends Node2D



@onready var string: Line2D = $Line2D
@onready var natural_string_position: float = string.get_point_position(2).x



func set_string_position(x: float):
	string.set_point_position(2, Vector2(x, 0))

func draw_bow(length: float, duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_string_position, natural_string_position, natural_string_position - length, duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await tween.finished

func shoot(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_method(set_string_position, string.get_point_position(1).x, natural_string_position, duration).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await tween.finished
