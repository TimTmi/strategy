class_name BowShootAnimator extends Node



func animate_shot(bow: Bow, arrow: Projectile, draw_distance: float, draw_duration: float, hold_duration: float) -> void:
	bow.global_transform = Transform2D(arrow.facing_angle, arrow.position - Vector2(0, arrow.height_offset))
	var tween = create_tween()
	tween.tween_property(arrow, "global_position", -Vector2.RIGHT.rotated(arrow.facing_angle) * draw_distance, draw_duration).as_relative().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	await bow.draw_bow(draw_distance, draw_duration)
	await get_tree().create_timer(hold_duration).timeout
