class_name ParallelActionSet extends ActionComponent



@export var actions: Array[ActionComponent]



func apply(context: ActionContext) -> void:
	for action in actions:
		action.apply(context)
