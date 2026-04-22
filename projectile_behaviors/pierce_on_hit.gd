class_name PierceOnHit extends ProjectileBehavior



#class PierceAnimator extends Node:
	#var _projectile: Projectile
	#var _projectile_length: float
	#var _pierce_position_getter: Callable
	#
	#
	#
	#func _ready() -> void:
		#set_physics_process(false)
	#
	#func _physics_process(_delta: float) -> void:
		#_pierce()
	#
	#func set_projectile(projectile: Projectile) -> void:
		#_projectile = projectile
		#_projectile_length = projectile.sprite.region_rect.size.x
	#
	#func animate(target: Node2D, target_rid: RID) -> void:
		#if target is PhysicsBody2D:
			#_pierce_position_getter = _get_pierce_position_physics_body.bind(_projectile, target)
		#elif target is TileMapLayer:
			#_pierce_position_getter = _get_pierce_position_tilemap_cell.bind(_projectile, target, target_rid)
		#else:
			#return
		#
		#set_physics_process(true)
	#
	#func _pierce():
		#var y_difference: float = _pierce_position_getter.call() - _projectile.global_position.y
		#var cutoff_position: float = abs(y_difference / sin(_projectile.facing_angle))
		#cutoff_position = clampf(cutoff_position, 0, _projectile_length)
		#if _projectile.facing_angle < 0:
			#_projectile.sprite.region_rect.size.x = cutoff_position
		#else:
			#_projectile.sprite.region_rect.size.x = _projectile_length - cutoff_position
			#_projectile.sprite.region_rect.position.x += cutoff_position
	#
	#func _get_pierce_position_physics_body(projectile: Projectile, body: PhysicsBody2D) -> float:
		#return body.global_position.y - projectile.height_offset
#
	#func _get_pierce_position_tilemap_cell(projectile: Projectile, body: TileMapLayer, body_rid: RID) -> float:
		#var tile_coords: Vector2i = body.get_coords_for_body_rid(body_rid)
		#return body.map_to_local(tile_coords).y + body.tile_set.tile_size.y * 0.5  - projectile.height_offset



@export var pierce_count: int = 0
var remaining_pierces: int = pierce_count



func on_spawn(projectile: Projectile, _context: ProjectileContext) -> void:
	remaining_pierces = pierce_count
	projectile.max_contacts_reported = pierce_count + 1
	projectile.y_sort_enabled = true
	
	var sprite_container := Node2D.new()
	var projectile_length: float = projectile.sprite.region_rect.size.x
	for i: int in projectile_length:
		var sprite_base := Node2D.new()
		var sprite: Sprite2D = projectile.sprite.duplicate()
		var region_rect = sprite.region_rect
		sprite_base.position = Vector2(-projectile_length * 0.5 + i + 0.5, 0)
		sprite.region_rect = Rect2(region_rect.position.x + i, region_rect.position.y, 1, region_rect.size.y)
		sprite.position = Vector2(0, -projectile.height_offset)
		projectile.rotatables.append(sprite)
		projectile.nonrotatables.append(sprite_base)
		sprite_base.add_child(sprite)
		sprite_container.add_child(sprite_base)
		
		#var test_sprite := Sprite2D.new()
		#test_sprite.texture = preload("res://sprites/black.png")
		#sprite_base.add_child(test_sprite)
	projectile.rotatables.append(sprite_container)
	projectile.sprite.hide()
	sprite_container.y_sort_enabled = true
	projectile.add_child(sprite_container)
	
	var _trigger_area := Area2D.new()
	var _trigger_collision_shape := CollisionShape2D.new()
	var _rectangle_shape := RectangleShape2D.new()
	_trigger_area.collision_layer = projectile.collision_layer
	_trigger_area.collision_mask = projectile.collision_mask
	_trigger_area.position = projectile.sprite.position
	_rectangle_shape.size = projectile.sprite.region_rect.size * projectile.sprite.scale
	_trigger_collision_shape.shape = _rectangle_shape
	projectile.add_child(_trigger_area)
	_trigger_area.add_child(_trigger_collision_shape)
	projectile.rotatables.append(_trigger_area)
	#_trigger_area.body_shape_entered.connect(_trigger_area_body_shape_entered)

func on_update(projectile: Projectile, delta: float, context: ProjectileContext) -> void:
	var collision: KinematicCollision2D = projectile.move_and_collide(projectile.linear_velocity * delta, true)
	if collision and remaining_pierces > 0:
		remaining_pierces -= 1
		var collider: Object = collision.get_collider()
		if collider is Character:
			projectile.hit(collision.get_collider_rid(), collider, collision.get_collider_shape_index(), 0)
			projectile.add_collision_exception_with(collider)

#func on_hit(projectile: Projectile, body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int, context: ProjectileContext) -> void:
	#projectile.reparent.call_deferred(body)
	#projectile.freeze = true

#func _trigger_area_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	#_pierce_animator.animate(body, body_rid)
