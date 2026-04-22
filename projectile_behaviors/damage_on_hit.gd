class_name DamageOnHit extends ProjectileBehavior



@export var amount: float = 1



func on_hit(_projectile: Projectile, _body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int, context: ProjectileContext) -> void:
	if body is Character:
		context.caster.attack(body, amount)
