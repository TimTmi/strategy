extends Node2D


var events: Array[Array] = []
var turn: int:
	set(value):
		turn = clamp(value, 0, events.size())
		turn_changed.emit(turn)
var current_character: Character
var player_team: String = "team_1"
var teams: Array = [
	{
		"name": "team_1",
		"color": Color8(0,130,200),
		"characters": ["character", "character"]
	},
	
	{
		"name": "team_2",
		"color": Color8(200,60,0),
		"characters": ["character", "character"]
	}
]


signal turn_changed
signal game_ended


func _ready():
	print($Box.get_used_rect())
	for i in 100:
		events.append([])
	var end_event = Event.new(emit_signal.bind("game_ended"))
	add_event(end_event, 99)
	for team in teams:
		for i in team.characters:
			var character: Character = load("res://characters/%s.tscn" %i).instantiate()
			character.add_to_group("characters")
			character.add_to_group(team.name)
			character.modulate = team.color
			character.team = team.name
			character.position = Vector2(96,192)
			add_child(character)
#			character.coord_changed.connect(_on_character_coord_changed)
#			character.turn_started.connect(_on_character_turn_started)
#			character.turn_ended.connect(_on_character_turn_ended)
	get_next_event().execute()

func add_event(event: Event, _turn: int):
	events[min(turn + _turn, events.size() - 1)].append(event)
	event.executed.connect(_on_event_executed)

func get_next_event():
	for i in range(turn, events.size()):
		if not events[i].is_empty():
			turn = i
			return events[turn].pop_front()

func _on_event_executed():
	get_next_event().execute()
