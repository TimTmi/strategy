class_name TimelinePointMarker extends TimelinePoint



var marking_tween: Tween



func mark(turn: int):
	set_turn(turn)
	
	if marking_tween:
		marking_tween.kill()
	
	marking_tween = create_tween()
	marking_tween.tween_property(self, "modulate:a", 1, 0.2)
	#marking_tween.set_trans(Tween.TRANS_SINE)
	#marking_tween.set_loops()
	#marking_tween.tween_property(label, "scale", Vector2(2,2), 0.5)
	#marking_tween.tween_property(label, "scale", Vector2.ONE, 0.5)

func unmark():
	if marking_tween:
		marking_tween.kill()
	marking_tween = create_tween()
	marking_tween.tween_property(self, "modulate:a", 0, 0.2)
