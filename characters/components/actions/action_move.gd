extends Action



@export var character: Character
@export var navigation_agent: NavigationAgent2D

var speed: int



func _ready() -> void:
	set_physics_process(false)
	navigation_agent.navigation_finished.connect(_on_navigation_finished)

func _physics_process(_delta: float) -> void:
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var velocity: Vector2 = character.global_position.direction_to(next_path_position) * speed
	character.apply_central_force(velocity)
	character.flip_sprite(velocity.x < 0)

func _on_velocity_computed(velocity: Vector2) -> void:
	velocity = velocity.normalized() * speed
	character.apply_central_force(velocity)

func _on_navigation_finished() -> void:
	set_physics_process(false)
	character.play_animation("idle")

func move_to(movement_target: Vector2):
	speed = character.speed.value * character.mass * 50
	navigation_agent.set_target_position(movement_target)
	set_physics_process(true)

func move(destination: Vector2):
	await process_input(destination)
	
	character.play_animation("moving")
	
	move_to(destination)
	await navigation_agent.navigation_finished
