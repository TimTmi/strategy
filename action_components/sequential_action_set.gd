class_name SequentialActionSet extends ActionComponent



@export var actions: Array[ActionComponent]



func apply(context: Dictionary) -> void:
	for action in actions:
		await action.apply(context)
