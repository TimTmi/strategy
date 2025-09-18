class_name Projectile extends RigidBody2D



@export var collision_shape: CollisionShape2D
@export var height_offset: float

var facing_angle: float = 0



func face(angle: float) -> void:
	facing_angle = angle
	for i in get_children():
		if i is Node2D:
			i.global_rotation = angle
