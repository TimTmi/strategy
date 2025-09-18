class_name ConditionalActionSet extends ActionComponent



@export var conditions: Array[ConditionComponent]
@export var action: ActionComponent



func apply(context: ActionContext) -> void:
	for condition in conditions:
		if not condition.is_satisfied(context):
			return
	
	action.apply(context)
