class_name Attack extends Interaction



var on_hit_effects: Array[OnHitEffect]



func _init(init_amount: float, init_target: Character, init_source: Character = null, init_on_hit_effects: Array[OnHitEffect] = []) -> void:
	super._init(init_amount, init_target, init_source)
	on_hit_effects = init_on_hit_effects
