extends Action


@export var health: Stat

signal out_of_health



func set_health(value: float):
	await process_input(value)
	health.current = value
	if value <= 0:
		out_of_health.emit()
