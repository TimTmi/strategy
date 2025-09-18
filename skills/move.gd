class_name Move extends Skill



@onready var max_distance: int = stats.get("max_distance", 0)



func _ready_extended() -> void:
	inputs = [
		SkillInput.new(func(): return InputInstructionPosition.new(ShapeCircle.new(user.global_position, max_distance)))
	]

func _use_extended() -> void:
	await user.move(Vector2i(inputs[0].data))
