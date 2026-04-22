class_name ProjectileBehavior extends Resource



func on_spawn(projectile: Projectile, context: ProjectileContext) -> void:
	pass

func on_update(projectile: Projectile, delta: float, context: ProjectileContext) -> void:
	pass

func on_hit(projectile: Projectile, body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int, context: ProjectileContext) -> void:
	pass

func on_expire(projectile: Projectile, context: ProjectileContext) -> void:
	pass
