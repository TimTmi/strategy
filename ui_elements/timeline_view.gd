class_name TimelineView extends Control



var max_points_viewed: int



func get_first_point() -> TimelinePoint:
	if get_child_count() < 2:
		return null
	return get_child(2)

func add_point() -> void:
	var point = TimelinePoint.new()
	add_child(point)
