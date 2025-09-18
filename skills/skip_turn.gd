extends Skill



func _ready_extended() -> void:
	inputs = [
		SkillInput.new(func(): return InputInstructionInt.new(1))
	]

func get_used_turn() -> int:
	return inputs[0].data
