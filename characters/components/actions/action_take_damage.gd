extends Action



@export var character: Character

signal damage_taken(amount: float, from: Character)



func take_damage(interaction: Interaction):
	await process_input(interaction)
	
	var target: Character = interaction.target
	var amount: float = interaction.amount
	var tween: Tween = target.create_tween()
	var origin: Color = target.self_modulate
	var current_animation: StringName
	var current_frame: int
	var current_frame_progress: float
	
	if interaction.amount == 0:
		tween.tween_property(target, "modulate", Color(1,1,0), 0.2)
	else:
		var sprite: AnimatedSprite2D = character.sprite
		current_animation = sprite.animation
		current_frame = sprite.frame
		current_frame_progress = sprite.frame_progress
		character.play_animation("hurt")
		tween.tween_property(target, "modulate", Color(1,0.6,0.6), 0.2)
	
	tween.tween_property(target, "modulate", origin, 0.2)
	await tween.finished
	
	character.play_animation(current_animation)
	target.set_health(target.health.current - amount)
	damage_taken.emit(amount, interaction.source)
