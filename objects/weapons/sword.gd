class_name Sword extends Area2D



@export var trail: GhostTrail



func _ready() -> void:
	z_index = RenderLayers.WORLD
