class_name Projectile extends RigidBody2D



@export var size: Vector2 = Vector2(4,4)
@export var height_offset: float = 8
@export var behaviors: Array[ProjectileBehavior]

@export_group("References")
@export var sprite: Sprite2D
@export var shadow: Shadow
@export var collision_shape: CollisionPolygon2D
@export var trail: GhostTrail
@export var rotatables: Array[Node2D]
@export var nonrotatables: Array[Node2D]



var context: ProjectileContext
var facing_angle: float = 0



func _ready() -> void:
	var ellipse_points: PackedVector2Array = EllipseGenerator.get_ellipse_points(size)
	shadow.draw_shadow(ellipse_points)
	collision_shape.set_polygon(ellipse_points)
	
	body_shape_entered.connect(_on_body_shape_entered)
	
	for behavior: ProjectileBehavior in behaviors:
		behavior.on_spawn(self, context)

func _physics_process(delta: float) -> void:
	for behavior: ProjectileBehavior in behaviors:
		behavior.on_update(self, delta, context)

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if not body is Node2D:
		return
	
	hit(body_rid, body, body_shape_index, local_shape_index)

func set_physics_layer(layer: int, mask: int) -> void:
	collision_layer = layer
	collision_mask = mask

func expire() -> void:
	var functions: Array[Callable]
	for behavior: ProjectileBehavior in behaviors:
		functions.append(behavior.on_expire.bind(self, context))
	var function_set: FunctionSet = FunctionSet.new(functions)
	await function_set.call_all()
	
	queue_free()

func face(angle: float) -> void:
	facing_angle = angle
	for node: Node2D in rotatables:
		node.global_rotation = angle
	for node: Node2D in nonrotatables:
		node.global_rotation = 0

func hit(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	for behavior: ProjectileBehavior in behaviors:
		behavior.on_hit(self, body_rid, body, body_shape_index, local_shape_index, context)
