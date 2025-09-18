extends Character



@onready var eyes: AnimatedSprite2D = $Sprite/Eyes



func recolor(new_color: Color) -> void:
	eyes.modulate = new_color

#func _play_animation_extended(animation: StringName) -> void:
	#if not eyes.sprite_frames.has_animation(animation):
		#return
	#eyes.play(animation)
