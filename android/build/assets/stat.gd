extends Node
class_name Stat


@onready var parent = get_parent()
@export var init: int = 10:
	set(value):
		init = maxi(value, 1)
		current = mini(current, init)
var current: int = init:
	set(value):
		if current == value:
			return
		current = clampi(value, 0, init)
		stat_changed.emit(current)


signal stat_changed
