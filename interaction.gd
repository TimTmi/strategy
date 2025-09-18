extends Resource
class_name Interaction



var amount: float
var source: Character
var target: Character
var effects: Array[InteractionEffect]



func _init(init_amount: float, init_target: Character, init_source: Character = null, init_effects: Array[InteractionEffect] = []) -> void:
	amount = init_amount
	source = init_source
	target = init_target
	effects = init_effects
