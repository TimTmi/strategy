extends ScrollContainer



func _ready() -> void:
	var v_scroll_bar := get_v_scroll_bar()
	v_scroll_bar.size_flags_horizontal = Control.SIZE_SHRINK_END
	v_scroll_bar.custom_minimum_size = Vector2(4, 0)
