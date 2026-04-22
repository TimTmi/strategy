class_name ParallelActionSet extends ActionComponent



@export var actions: Array[ActionComponent]



func apply(context: Dictionary) -> void:
	for action in actions:
		action.apply(context)
