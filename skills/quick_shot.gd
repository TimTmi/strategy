extends Skill



const BOW: PackedScene = preload("res://objects/weapons/bow.tscn")
const ARROW: PackedScene = preload("res://objects/projectiles/arrow.tscn")

@export var physics_layer_controller: LayerController
@export var projectile_setup: ProjectileSetup
@export var shooting_force: float = 128

@onready var bow: Bow = BOW.instantiate()
@onready var damage: float = stats.get("damage", 0)
var arrow: Projectile



func _ready_extended() -> void:
	inputs = [
		SkillInput.new(func(): return InputInstructionDirection.new(user.global_position, 32))
	]
	
	bow.modulate.a = 0
	user.add_child.call_deferred(bow)

func _use_extended() -> void:
	var angle = inputs[0].data
	
	var arrow_transform: Transform2D = Transform2D(0.0, user.global_position + Vector2.RIGHT.rotated(angle) * 4)
	arrow = NodeCreator.create_projectile(
		projectile_setup,
		arrow_transform,
		physics_layer_controller.get_layer_bitmask(user.team, ["projectiles"]),
		physics_layer_controller.get_layer_bitmask(user.team, [], true),
		ProjectileContext.new(user)
	)
	arrow.z_index = 1
	spawner.spawn_projectile(arrow)
	
	#bow.rotation = angle
	#bow.position.y = -arrow.height_offset
	
	arrow.face(angle)
	arrow.set_physics_layer(
		physics_layer_controller.get_layer_bitmask(user.team, ["projectiles"]),
		physics_layer_controller.get_layer_bitmask(user.team, [], true)
	)
	
	bow.global_transform = Transform2D(arrow.facing_angle, arrow.position - Vector2(0, arrow.height_offset))
	
	FadeAnimator.fade_in(bow, 0.2, 0)
	var bow_shoot_animator := BowShootAnimator.new()
	add_child(bow_shoot_animator)
	await FadeAnimator.fade_in(arrow, 0.2, 0)
	await bow_shoot_animator.animate_shot(bow, arrow, 4, 0.5, 0.1)
	
	#var tween = create_tween()
	#tween.tween_property(arrow, "global_position", user.global_position + Vector2.RIGHT.rotated(angle), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	#
	#await bow.draw_bow(8, 0.5)
	#await get_tree().create_timer(0.1).timeout
	#arrow.start_trail()
	arrow.apply_central_impulse(Vector2.RIGHT.rotated(angle) * shooting_force)
	await bow.shoot(0.2)
	arrow.z_index = 0
	
	await FadeAnimator.fade_out(bow, 0.2)

func _on_arrow_hit(body: Node) -> void:
	#arrow.add_collision_exception_with(body)
	arrow.set_deferred("contact_monitor", false)
	arrow.set_deferred("freeze", true)
	arrow.reparent.call_deferred(body)
	arrow.stop_trail()
	#if body is Character:
		#user.attack(body, damage)
	
	await get_tree().create_timer(0.3).timeout
	
	FadeAnimator.fade_out(arrow, 0.2)
