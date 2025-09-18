class_name SpawnAreaComponent extends ActionComponent



@export var area_scene: PackedScene
@export var duration: float



func apply(context: ActionContext) -> void:
	var area: Area2D = area_scene.instantiate()
	area.global_position = context.source.global_position
