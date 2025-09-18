class_name SkillInputHandler extends Node2D



var input_getter_functions := {
	InputInstruction.InputType.POSITION: get_input_position,
	InputInstruction.InputType.DIRECTION: get_input_direction,
	InputInstruction.InputType.TARGET: get_input_target,
	InputInstruction.InputType.INT: get_input_int
}

var room_rect = Rect2(16, 112, 160, 160)
var target: Node = null

var skill_input_preview: SkillInputPreview



signal getting_skill_input
signal got_skill_input



func get_skill_input(instruction: InputInstruction) -> Variant:
	getting_skill_input.emit()
	
	var input: Variant = await input_getter_functions[instruction.get_type()].call(instruction)
	got_skill_input.emit()
	return input

func validate_skill_input(input: String, instruction: InputInstruction) -> bool:
	var converted_input = instruction.string_to_data(input)
	if converted_input == null:
		return false
	return true

func get_input_position(instruction: InputInstructionPosition):
	var input_getter = $MouseInputGetter
	var input: Vector2 = await input_getter.get_input(instruction.get_drawing_instruction())
	if input == Vector2.INF:
		return null
	skill_input_preview.preview_input_position(input)
	return input

func get_input_direction(instruction: InputInstructionDirection):
	var input_getter = $MouseInputGetter
	var input: Vector2 = await input_getter.get_input(instruction.get_drawing_instruction())
	if input == Vector2.INF:
		return null
	var angle: float = (input - instruction.center).angle()
	if instruction.input_is_valid(angle):
		skill_input_preview.preview_input_direction(instruction.center, angle, instruction.radius)
		return angle
	return null

func get_input_target(instruction: InputInstructionTarget):
	var touchable_objects: Array[Node] = get_tree().get_nodes_in_group("touchableObjects")
	var input_getter = $MouseInputGetter
	var set_target = func(new_target): target = new_target
	
	for i: Node in touchable_objects:
		var button: TouchScreenButton = i.get_node("Button")
		button.pressed.connect(set_target.bind(i))
		
	input_getter.get_input(instruction.get_drawing_instruction())
	await input_getter.mouse_clicked
	
	for i in touchable_objects:
		var button: TouchScreenButton = i.get_node("Button")
		button.pressed.disconnect(set_target)
	
	return target

func get_input_int(instruction: InputInstructionInt):
	var input_getter: LineEdit = %IntInput
	input_getter.show()
	input_getter.grab_focus()
	var input: String = await input_getter.text_submitted
	input_getter.release_focus()
	input_getter.hide()
	input_getter.clear()
	return instruction.string_to_data(input)
