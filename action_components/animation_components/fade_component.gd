class_name FadeComponent extends AnimationComponent



@export_range(0, 1, 0.01) var fade_to: float = 1.0
@export var duration: float = 0.2



func apply(context: ActionContext) -> void:
	var node := get_animated_node(context)
	if not node:
		return
	
	var tween := node.create_tween()
	tween.tween_property(node, "modulate:a", fade_to, duration)
	await tween.finished
