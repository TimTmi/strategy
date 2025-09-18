extends Character



@onready var feather: AnimatedSprite2D = $Sprite/Feather



func recolor(new_color: Color) -> void:
	feather.modulate = new_color

#func _play_animation_extended(animation: StringName) -> void:
	#if not feather.sprite_frames.has_animation(animation):
		#return
	#feather.play(animation)
