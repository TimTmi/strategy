class_name AnimationComponent extends ActionComponent



@export var animated_node_key: StringName = "animated_node"



func get_animated_node(context: ActionContext) -> Node2D:
	return context.custom_data.get(animated_node_key)
