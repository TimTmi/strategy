extends HBoxContainer



@export_group("Dragging")
@export var damping: float = 0.2
@export var velocity_threshold: float = 6
@export var menu_switch_drag_distance: float = 64

var press_position: float
var drag_distance: float
var drag_velocity: float = 0
var tween: Tween



#func _physics_process(_delta: float) -> void:
	#if abs(drag_velocity) < velocity_threshold:
		#if current_index == snap_index && abs(drag_distance) >= menu_switch_drag_distance:
			#current_index = current_index - sign(drag_distance)
		#else:
			#current_index = snap_index
		#_snap_to_position(_get_menu_position(current_index))
		#set_physics_process(false)
	#
	#hbox.position.x += drag_velocity
	#drag_velocity = lerpf(drag_velocity, 0, damping)
#
#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventScreenTouch:
		#if event.pressed:
			#set_physics_process(false)
			#press_position = event.position.x
			#if tween:
				#tween.kill()
		#else:
			#set_physics_process(true)
			#drag_distance = event.position.x - press_position
	#
	#elif event is InputEventScreenDrag:
		#if event.index != 0:
			#return
		#var relative = event.relative.x
		#hbox.position.x += relative
		#drag_velocity = relative
#
#func _get_menu_position(menu_index: int) -> float:
	#var step: float = hbox.get_child(0).size.x + hbox.get_theme_constant("separation")
	#return menu_index * -step
#
#func _snap_to_position(snap_position: float) -> void:
	#if tween:
		#tween.kill()
	#
	#var tween_duration: float = 0.3
	#tween = create_tween()
	#tween.tween_property(hbox, "position:x", snap_position, tween_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
