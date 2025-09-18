extends Resource
class_name SkillInput


var instruction: Callable
var data

func _init(init_instruction: Callable):
	instruction = init_instruction

func get_instruction():
	return instruction.call()
