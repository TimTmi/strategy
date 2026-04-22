class_name Spawner extends Node


@export var foo: Callable
var characters_container: Node2D
var projectiles_container: Node2D
var trails_container: Node2D



signal character_spawned(character: Character)
signal projectile_spawned(projectile: Projectile)
signal trail_spawned(trail: Node2D)



func spawn_character(character: Character) -> void:
	character.spawner = self
	characters_container.add_child(character, true)
	character_spawned.emit(character)

func spawn_projectile(projectile: Projectile) -> void:
	projectiles_container.add_child(projectile)
	projectile_spawned.emit(projectile)

func spawn_trail(trail: Node2D) -> void:
	trails_container.add_child(trail)
	trail_spawned.emit(trail)
