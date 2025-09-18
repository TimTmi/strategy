extends Node



@export var menu_root: Control



func _get_configuration_warning() -> String:
	if menu_root == null:
		return "AutoHideOnFocusExit: 'menu_root' is not assigned!"
	return ""

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _on_focus_changed(node: Control) -> void:
	if node and (node == menu_root or menu_root.is_ancestor_of(node)):
		return
	menu_root.hide()
