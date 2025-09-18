extends Skill


@export var physics_layer_controller: LayerController

@onready var bow: Node2D = preload("res://objects/weapons/bow.tscn").instantiate()
@onready var damage: float = stats.get("damage", 0)
var arrow: PiercingProjectile



func _ready_extended() -> void:
	inputs = [
		SkillInput.new(func(): return InputInstructionDirection.new(user.global_position, 32))
	]
	
	bow.hide()
	user.add_child.call_deferred(bow)

func _use_extended() -> void:
	var angle = inputs[0].data
	arrow = preload("res://objects/projectiles/arrow.tscn").instantiate()
	
	bow.modulate.a = 0
	bow.rotation = angle
	bow.position.y = -arrow.height_offset
	bow.show()
	
	arrow.modulate.a = 0
	arrow.face(angle)
	arrow.position = user.global_position + Vector2.RIGHT.rotated(angle) * 10.5
	arrow.body_entered.connect(_on_arrow_hit)
	request_spawn_projectile.emit(arrow)
	#get_projectiles_node().add_child(arrow)
	#get_tree().current_scene.get_node("Map").add_child(arrow)
	#arrow.z_index = RenderLayers.PROJECTILES
	arrow.set_physics_layer(
		physics_layer_controller.get_layer_bitmask(user.team, ["projectiles"]),
		physics_layer_controller.get_layer_bitmask(user.team, [], true)
	)
	
	var tween: Tween = create_tween()
	tween.tween_property(bow, "modulate:a", 1, 0.1)
	tween.parallel().tween_property(arrow, "modulate:a", 1, 0.1)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property(arrow, "global_position", user.global_position + Vector2.RIGHT.rotated(angle) * 2.5, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	await bow.draw_bow(8, 0.5)
	await get_tree().create_timer(0.1).timeout
	#arrow.start_trail()
	arrow.apply_central_impulse(Vector2.RIGHT.rotated(angle) * 512)
	await bow.shoot(0.2)
	
	tween = create_tween()
	tween.tween_interval(0.1)
	tween.tween_property(bow, "modulate:a", 0, 0.1)
	
	await tween.finished

func _on_arrow_hit(body: Node) -> void:
	arrow.set_deferred("contact_monitor", false)
	arrow.set_deferred("freeze", true)
	arrow.reparent.call_deferred(body)
	arrow.stop_trail()
	#arrow.set_deferred("freeze", true)
	if body is Node2D:
		#arrow.pierce(body)
		if body is Character:
			user.attack(body, damage)
	
	await get_tree().create_timer(0.3).timeout
	
	var tween := create_tween()
	tween.tween_property(arrow, "modulate:a", 0, 0.3)
	tween.tween_callback(arrow.queue_free)
