class_name ConditionalActionSet extends ActionComponent



enum ExecutionMode { SEQUENTIAL, PARALLEL }

@export var execution_mode: ExecutionMode = ExecutionMode.SEQUENTIAL



func apply(context: Dictionary) -> void:
	for condition: Node in get_children():
		if condition is Condition and (condition as Condition).is_satisfied(context):
			for action: Node in condition.get_children():
				if action is ActionComponent:
					match execution_mode:
						ExecutionMode.SEQUENTIAL:
							await (action as ActionComponent).apply(context)
						ExecutionMode.PARALLEL:
							(action as ActionComponent).apply(context)
