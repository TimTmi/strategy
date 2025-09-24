extends "res://ui_elements/timeline_view.gd"



const EVENT_TIMELINE_POINT = preload("res://ui_elements/timeline_point.tscn")
const INITIALS_LABEL = preload("res://ui_elements/initials_label.tscn")

@export var point_offset := Vector2.ZERO
@export var animated: bool = true
@export_group("Animation Duration", "animation_duration")
@export var animation_duration_add_event := 0.2
@export var animation_duration_remove_event := 0.2
@export var animation_duration_scroll := 0.2
@export var animation_duration_zoom := 0.2

var sample_point: TimelinePoint
var points: Array[TimelinePoint]
var viewed_events_count: int = 0

var max_points: int:
	set(value):
		max_points = maxi(value, 0)
		points.resize(max_points)

@onready var marker: TimelinePointMarker = preload("res://ui_elements/timeline_point_marker.tscn").instantiate()



func _ready() -> void:
	$ScrollContainer/Control.custom_minimum_size = Vector2(sample_point.size.x * points.size(), sample_point.size.y)
	$ScrollContainer/Control.add_child(marker)
	if not animated:
		animation_duration_add_event = 0
		animation_duration_remove_event = 0
		animation_duration_scroll = 0
		animation_duration_zoom = 0

func _on_event_added(turn: int, event: Event) -> void:
	var point: TimelinePoint = points[turn]
	
	if point == null:
		point = EVENT_TIMELINE_POINT.instantiate()
		points[turn] = point
		point.position = Vector2(point.size.x * turn, 0) + point_offset
		point.set_turn(turn)
		point.animation_duration_add_decoration = animation_duration_add_event
		point.animation_duration_remove_decoration = animation_duration_remove_event
		$ScrollContainer/Control.add_child(point)
	
	sample_point = point
	
	match event.callable.get_method():
		"start_turn":
			var character: Character = event.callable.get_bound_arguments().front()
			var label := INITIALS_LABEL.instantiate()
			event.invalidated.connect(point.remove_decoration.bind(label))
			label.set_initials(character)
			point.add_decoration(label)

func _on_turn_changed(turn: int) -> void:
	create_tween().tween_property($ScrollContainer, "scroll_horizontal", turn * sample_point.size.x, animation_duration_scroll)

func get_point(turn: int) -> TimelinePoint:
	if turn < 0 or turn >= points.size():
		return null
	
	return points[turn]

func mark_turn(turn: int) -> void:
	marker.position = Vector2(marker.size.x * turn, 0) + point_offset
	$ScrollContainer/Control.move_child(marker, -1)
	marker.mark(turn)

func unmark_turn() -> void:
	marker.unmark()
