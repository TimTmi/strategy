class_name EventManager extends Node


@export var turns_per_game: int = 100
var events: Array[Array]
var turn: int = 0:
	set(value):
		var old_turn = turn
		turn = clamp(value, 0, events.size())
		if turn != old_turn:
			turn_changed.emit(turn)
var ongoing_subevents: int = 0:
	set(value):
		ongoing_subevents = value
		#print(ongoing_subevents)
		if ongoing_subevents == 0:
			event_finished.emit()



signal event_added(turn: int, event: Event)
signal event_finished
signal turn_changed
signal game_ended



func _ready() -> void:
	%EventTimelineView.max_points = turns_per_game
	for i in turns_per_game:
		events.append([])
	var end_event = Event.new(game_ended.emit)
	add_event(end_event, turns_per_game - 1)

func clamp_turn(clamped_turn: int) -> int:
	return mini(clamped_turn, events.size() - 2)

func add_event(event: Event, turns: int) -> void:
	var target_turn = clamp_turn(turn + turns)
	events[target_turn].append(event)
	event_added.emit(target_turn, event)

func start_next_event() -> bool:
	for i in range(turn, events.size()):
		while not events[i].is_empty():
			var event: Event = events[i].pop_front()
			if not event.valid:
				continue
			turn = i
			event.execute()
			return true
	return false

func _on_world_setup_finished():
	var increment_subevents = func(): ongoing_subevents += 1
	var decrement_subevents = func(): ongoing_subevents -= 1
	
	for i in get_tree().get_nodes_in_group("subeventsTracked"):
		i.triggering_subevent.connect(increment_subevents)
		i.triggered_subevent.connect(decrement_subevents)

func _on_event_finished():
	start_next_event()
