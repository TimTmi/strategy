extends RigidBody2D
class_name Character


@onready var health = $Health
@onready var energy = $Energy
@onready var speed = $Speed
@export var skills: Array[Skill]
var team: String


signal health_changed
signal attack_changed
signal speed_changed
signal turn_started
signal turn_ended
