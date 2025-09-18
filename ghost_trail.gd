class_name GhostTrail extends Node2D



@export_range(0, 1, 0.01, "or_greater") var interval: float = 0.05
@export_range(0, 1, 0.01, "or_greater") var ghost_lifetime: float = 0.2
@export_range(0, 1, 0.01) var alpha: float = 1

@onready var timer: Timer = $Timer

var parent: Node
var create_ghost: Callable



func _ready() -> void:
	timer.wait_time = interval
	parent = get_parent()
	if not parent:
		return
	if parent is Sprite2D:
		create_ghost = create_ghost_static
	elif parent is AnimatedSprite2D:
		create_ghost = create_ghost_animated

func _on_timeout() -> void:
	var ghost: Sprite2D = create_ghost.call(parent)
	ghost.modulate.a = alpha
	get_tree().get_first_node_in_group("trails").get_parent().add_child(ghost)
	var tween = ghost.create_tween()
	tween.tween_property(ghost, "modulate:a", 0, ghost_lifetime)
	#tween.tween_interval(0.1)
	#tween.tween_callback(func(): get_tree().paused = true)
	tween.tween_callback(ghost.queue_free)

func create_ghost_static(sprite: Sprite2D) -> Sprite2D:
	var ghost: Sprite2D = sprite.duplicate(0)
	ghost.global_transform = sprite.global_transform
	return ghost

func create_ghost_animated(sprite: AnimatedSprite2D) -> Sprite2D:
	var ghost: Sprite2D = Sprite2D.new()
	ghost.texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	ghost.centered = sprite.centered
	ghost.offset = sprite.offset
	ghost.flip_h = sprite.flip_h
	ghost.flip_v = sprite.flip_v
	ghost.global_transform = sprite.global_transform
	return ghost

func start() -> void:
	timer.start()

func stop() -> void:
	timer.stop()
