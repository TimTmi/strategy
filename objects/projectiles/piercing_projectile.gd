class_name PiercingProjectile extends Projectile



@export var back: Sprite2D
@export var front: Sprite2D

@onready var max_length = front.region_rect.size.x

#var pierce_position: float
var pierce_position_getter: Callable



func _ready() -> void:
	super._ready()
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	pierce()

func set_physics_layer(layer: int, mask: int) -> void:
	collision_layer = layer
	collision_mask = mask
	
	var area: Area2D = $Area2D
	area.collision_layer = layer
	area.collision_mask = mask

func pierce():
	var y_difference: float = pierce_position_getter.call() - global_position.y
	var cutoff_position: float = abs(y_difference / sin(facing_angle))
	cutoff_position = clampf(cutoff_position, 0, max_length)
	if facing_angle < 0:
		front.region_rect.size.x = cutoff_position
	#else:
		#front.region_rect.size.x = max_length - cutoff_position
		#front.region_rect.position.x += cutoff_position

func start_trail() -> void:
	if trail:
		trail.start()

func stop_trail() -> void:
	if trail:
		trail.stop()

#func get_pierce_position_physics_body(body: PhysicsBody2D) -> float:
	#return body.global_position.y - height_offset
#
#func get_pierce_position_tilemap_cell(body: TileMapLayer, body_rid: RID) -> float:
	#var tile_coords: Vector2i = body.get_coords_for_body_rid(body_rid)
	#return body.map_to_local(tile_coords).y + body.tile_set.tile_size.y * 0.5  - height_offset
#
#func _on_body_shape_entered(body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	#if body is PhysicsBody2D:
		#pierce_position_getter = get_pierce_position_physics_body.bind(body)
	#elif body is TileMapLayer:
		#pierce_position_getter = get_pierce_position_tilemap_cell.bind(body, body_rid)
	#else:
		#return
	#
	#set_physics_process(true)
