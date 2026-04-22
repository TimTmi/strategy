class_name NodeCreator



#static func spawn(packed_scene: PackedScene, spawn_function: Callable, global_transform: Transform2D, setup_function: Callable) -> Node:
	#var node: Node = packed_scene.instantiate()
	#
	#if node is Node2D:
		#node.set_global_transform(global_transform)
	#
	#setup_function.call(node)
	#spawn_function.call(node)
	#
	#var timer: Timer = Timer.new()
	#timer.wait_time = lifetime
	#timer.one_shot = true
	#node.add_child(timer)
	#timer.timeout.connect(node.queue_free)
	#timer.start()
	#
	#return node

static func create_node2d(packed_scene: PackedScene, global_transform: Transform2D, collision_layer: int, collision_mask: int) -> Node2D:
	var node: Node2D = packed_scene.instantiate() as Node2D
	
	if not node:
		node.queue_free()
		return
	
	node.global_transform = global_transform
	node.collision_layer = collision_layer
	node.collision_mask = collision_mask
	
	return node

static func create_projectile(setup: ProjectileSetup, global_transform: Transform2D, collision_layer: int, collision_mask: int, context: ProjectileContext = ProjectileContext.new()) -> Projectile:
	var projectile: Projectile = create_node2d(setup.projectile_scene, global_transform, collision_layer, collision_mask) as Projectile
	
	if not projectile:
		projectile.queue_free()
		return
	
	const StackBehavior := Enums.StackBehavior
	var base_behaviors := projectile.behaviors
	
	for config: ProjectileBehaviorConfig in setup.behaviors:
		match config.stack_behavior:
			StackBehavior.APPEND:
				base_behaviors.append(config.behavior)
			StackBehavior.REMOVE:
				for behavior: ProjectileBehavior in base_behaviors:
					#if behavior.
					pass
			StackBehavior.OVERRIDE:
				pass
			StackBehavior.REPLACE:
				base_behaviors.clear()
				base_behaviors.append(config.behavior)
	
	#projectile.behaviors.append_array(setup.behaviors)
	projectile.context = context
	
	return projectile

#static func spawn_projectile(setup: ProjectileSetup, spawn_function: Callable, global_transform: Transform2D, collision_layer: int, collision_mask: int, context: ProjectileContext):
	#return spawn(setup.projectile_scene, spawn_function, global_transform, setup_projectile.bind(setup, context))
#
#static func setup_projectile(projectile: Projectile, projectile_setup: ProjectileSetup, projectile_context: ProjectileContext):
	#projectile.behaviors.append_array(projectile_setup.behaviors)
	#projectile.context = projectile_context
