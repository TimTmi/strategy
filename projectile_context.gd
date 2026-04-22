class_name ProjectileContext extends Resource



var caster: Character
var target: Character
var custom_data: Dictionary



func _init(init_caster: Node2D = null, init_target: Node2D = null, init_custom_data: Dictionary = {}) -> void:
	caster = init_caster
	target = init_target
	custom_data = init_custom_data
