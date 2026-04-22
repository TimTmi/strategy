class_name FadeOnHit extends ProjectileBehavior



@export var delay: float = 0.3
@export var duration: float = 0.2
@export var fade_from: float = NAN
@export var fade_to: float = 0.0



func on_hit(projectile: Projectile, body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int, context: ProjectileContext) -> void:
	var tween := projectile.create_tween()
	tween.tween_interval(delay)
	tween.tween_callback(FadeAnimator.fade.bind(projectile, fade_to, duration, fade_from))
