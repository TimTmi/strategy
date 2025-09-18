class_name Character extends RigidBody2D



@export var size: Vector2i = Vector2i(16, 8)

@onready var health: Stat = $Stats/Health
@onready var energy: Stat = $Stats/Energy
@onready var speed: Stat = $Stats/Speed
@onready var button: TouchScreenButton = $Button
@onready var abilities: Node = $Abilities
@onready var skills: Node = $Skills
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent
@onready var shadow: Node2D = $Shadow

var world: Node2D
var team: StringName
var color: Color:
	set(value):
		color = value
		recolor(color)
var layer_mask: int
var collision_points: PackedVector2Array

var spawner: Spawner



#signal health_changed
#signal attack_changed
#signal speed_changed
signal triggering_subevent
signal triggered_subevent
#signal turn_started
signal turn_ended(turns_used: int)



func _init(_world: Node2D = null) -> void:
	world = _world

func _ready() -> void:
	add_to_group("subeventsTracked")
	add_to_group("touchableObjects")
	
	#var sprite: AnimatedSprite2D = $Sprite
	#if sprite.sprite_frames.has_animation("idle"):
		#sprite.play("idle")
	
	shadow.z_index = RenderLayers.SHADOWS
	shadow.draw_shadow(size)
	$Collision.set_polygon(shadow.points)
	
	for skill: Skill in $Skills.get_children():
		skill.user = self
		skill.spawner = spawner
		skill.used.connect(_on_skill_used)
	
	_ready_extended()

func _ready_extended() -> void:
	pass

func get_skills() -> Array[Node]:
	return $Skills.get_children()

func recolor(new_color: Color) -> void:
	pass

func flip_sprite(flip: bool) -> void:
	sprite.flip_h = flip
	for i in sprite.get_children():
		if i is AnimatedSprite2D:
			i.flip_h = flip

func play_animation(animation: StringName) -> void:
	var sprite: AnimatedSprite2D = $Sprite
	if not sprite.sprite_frames.has_animation(animation):
		return
	sprite.play(animation)
	for i in sprite.get_children():
		if i is AnimatedSprite2D:
			if i.sprite_frames.has_animation(animation):
				i.play(animation)
	#_play_animation_extended(animation)

#func _play_animation_extended(animation: StringName) -> void:
	#pass

func highlight() -> Callable:
	var tween = create_tween().set_loops()
	var origin: Color = sprite.self_modulate
	var unhighlight = func():
		tween.kill()
		sprite.self_modulate = origin
	tween.tween_property(sprite, "self_modulate", origin.lightened(0.6), 0.5)
	tween.tween_property(sprite, "self_modulate", origin , 0.5)
	return unhighlight

func start_turn() -> void:
	pass

func perform_action(action: Callable):
	triggering_subevent.emit()
	await action.call()
	triggered_subevent.emit()

func move(destination: Vector2) -> void:
	await perform_action($Actions/Move.move.bind(destination))

func set_health(value: float) -> void:
	await perform_action($Actions/SetHealth.set_health.bind(value))

func heal(healing: Healing) -> void:
	await perform_action($Heal.heal.bind(healing))

func receive_healing(healing: Healing) -> void:
	await perform_action($ReceiveHealing.receive_healing.bind(healing))

#func deal_damage(damage: Damage) -> void:
	#await perform_action($Actions/DealDamage.execute.bind(damage))

func attack(character: Character, damage: int, effects: Array[InteractionEffect] = []):
	var interaction: Interaction = Interaction.new(damage, character, self, effects)
	await perform_action($Actions/Attack.attack.bind(interaction))

func receive_attack(interaction: Interaction):
	await perform_action($Actions/ReceiveAttack.receive_attack.bind(interaction))

func take_damage(interaction: Interaction) -> void:
	await perform_action($Actions/TakeDamage.take_damage.bind(interaction))

func die() -> void:
	triggering_subevent.emit()
	var dead = await $Actions/Die.die()
	if dead:
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(1,0,0,0), 0.2)
		await tween.finished
		queue_free()
		tree_exited.connect(func(): triggered_subevent.emit())
		return
	triggered_subevent.emit()

func _on_skill_used(turns_used: int) -> void:
	turn_ended.emit(turns_used)

func _on_out_of_health() -> void:
	die()
