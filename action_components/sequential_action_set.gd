class_name SequentialActionSet extends ActionComponent



@export var actions: Array[ActionComponent]



func apply(context: ActionContext) -> void:
	for action in actions:
		await action.apply(context)
