extends Node



@export var target: Control



func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	
	if target == null:
		warnings.append("AutoHideOnFocusExit: 'target' is not assigned!")
	
	return warnings

func _ready() -> void:
	set_process_input(target.visible)
	target.visibility_changed.connect(_on_target_visibility_changed)

func _on_target_visibility_changed() -> void:
	set_process_input(target.visible)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.pressed or event.button_index != MOUSE_BUTTON_LEFT:
			return
		
		if not target.get_global_rect().has_point(event.global_position):
			target.hide()

#func _ready() -> void:
	#get_viewport().gui_focus_changed.connect(_on_focus_changed)
#
#func _on_focus_changed(node: Control) -> void:
	#if node and (node == target or target.is_ancestor_of(node)):
		#return
	#target.hide()
