extends Skill



@export var physics_layer_controller: LayerController

@onready var stab_distance: int = stats.get("stab_distance", 0)
@onready var damage: int = stats.get("damage", 0)
@onready var knockback: int = stats.get("knockback", 0)

#var area: Area2D
@onready var sword: Sword = preload("res://objects/weapons/sword.tscn").instantiate()



func _ready_extended() -> void:
	inputs = [
		SkillInput.new(func(): return InputInstructionDirection.new(user.global_position, 32))
	]
	
	sword.hide()
	#update_layer_mask(sword, Collidable.COLLIDABLE_ENEMIES)
	user.add_child.call_deferred(sword)
	
	#var collision: CollisionShape2D = CollisionShape2D.new()
	#var rectangle: RectangleShape2D = RectangleShape2D.new()
	#area = Area2D.new()
	#area.add_child(collision)
	#collision.shape = rectangle
	#rectangle.size = Vector2(stab_distance, 8)
	#update_layer_mask(area, Collidable.COLLIDABLE_ENEMIES)
	#user.add_child.call_deferred(area)

func _use_extended() -> void:
	#var effect = preload("res://vfx/particles/thrust.tscn").instantiate()
	var angle = inputs[0].data
	#var end := stab_distance * Vector2.RIGHT.rotated(angle)
	
	sword.modulate.a = 0
	sword.position = Vector2.ZERO
	sword.global_rotation = angle
	sword.collision_layer = physics_layer_controller.get_layer_bitmask(user.team, ["statics"])
	sword.collision_mask = physics_layer_controller.get_layer_bitmask(user.team, [], true)
	sword.show()
	
	var tween: Tween = create_tween()
	tween.tween_property(sword, "modulate:a", 1, 0.1)
	tween.tween_property(sword, "position", -Vector2.RIGHT.rotated(angle) * 4, 0.1)
	tween.tween_callback(sword.trail.start)
	tween.tween_property(sword, "position", Vector2.RIGHT.rotated(angle) * stab_distance, 0.1)
	
	await tween.finished
	
	sword.trail.stop()
	for i in sword.get_overlapping_bodies():
		if i is Character:
			user.attack(i, damage)
			i.apply_central_impulse(Vector2.RIGHT.rotated(angle) * knockback)
	
	tween = create_tween()
	tween.tween_interval(0.1)
	tween.tween_property(sword, "modulate:a", 0, 0.1)
	
	await tween.finished
	
	#area.position = end * 0.5
	#area.rotation = angle
	
	#effect.position = effect_initial_distance * Vector2.RIGHT.rotated(angle)
	#effect.position = Vector2.ZERO
	#effect.rotation = angle
	#user.add_child(effect)
	
	#var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(effect, "position", Vector2.ZERO, 0.1)
	#tween.tween_property(effect, "position", effect.position, 0.2)
	#tween.tween_property(effect, "position", end, 0.2)
	
	#await tween.finished
	#for i in area.get_overlapping_bodies():
		#if i is Character:
			#user.attack(i, damage)
	#effect.emitting = false
	
	#await get_tree().create_timer(effect.lifetime).timeout
	#effect.queue_free()
