class_name Hitbox extends Area2D



func _ready() -> void:
	z_index = RenderLayers.WORLD

func set_physics_layer(layer: int, mask: int) -> void:
	collision_layer = layer
	collision_mask = mask
