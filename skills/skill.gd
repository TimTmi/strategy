extends Node
class_name Skill


@export var icon: Texture = preload("res://sprites/placeholder.png")
@export_multiline var description: String
@export var stats: Dictionary = { &"turn_cost": 5 }
@export var turn_cost: int = 5
@export var action: ActionComponent

var spawner: Spawner
var inputs: Array[SkillInput]
var user: Character:
	set(value):
		user = value
		_ready_extended()



signal used(turns_used: int)
signal triggering_subevent
signal triggered_subevent
signal request_spawn_character(character: Character)
signal request_spawn_projectile(projectile: Projectile)



func _ready() -> void:
	add_to_group("subeventsTracked")
	#_ready_extended()

func _ready_extended() -> void:
	pass

func use() -> void:
	triggering_subevent.emit()
	await _use_extended()
	used.emit(get_used_turn())
	triggered_subevent.emit()

func _use_extended() -> void:
	pass

func get_used_turn() -> int:
	return turn_cost

func clear_inputs() -> void:
	for i: SkillInput in inputs:
		i.data = null
