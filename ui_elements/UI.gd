class_name UI extends Control



@export var facade: UIFacade

@onready var initial_height: float = size.y
@onready var zoom: float = 1 / ProjectSettings.get_setting("display/window/stretch/scale", 1)

var has_virtual_keyboard: bool = false
var keyboard_height: int = 0
var active_autohide_nodes: Array[Control]



func _ready():
	set_process(false)
	has_virtual_keyboard = DisplayServer.has_feature(DisplayServer.FEATURE_VIRTUAL_KEYBOARD)
	#if not has_virtual_keyboard:
		#set_block_signals(true)
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _process(_delta):
	var new_keyboard_height: int = DisplayServer.virtual_keyboard_get_height()
	if keyboard_height == new_keyboard_height:
		return
	keyboard_height = new_keyboard_height
	size.y = initial_height - (keyboard_height * zoom) / get_viewport_transform().get_scale().y

func _on_virtual_keyboard_shown():
	set_process(true)
	#if has_virtual_keyboard:
		#set_process(true)

func _on_virtual_keyboard_hidden():
	set_process(false)
	size.y = initial_height

func _on_focus_changed(new_node: Control) -> void:
	var stop_index := -1
	
	for i in range(active_autohide_nodes.size() - 1, -1, -1):
		var node := active_autohide_nodes[i]
		if new_node and (new_node == node or node.is_ancestor_of(new_node)):
			stop_index = i
			break
		node.hide()
	
	if stop_index >= 0:
		active_autohide_nodes.resize(stop_index + 1)
	else:
		active_autohide_nodes.clear()
	
	if new_node and new_node.is_in_group("autohideNodes") and not active_autohide_nodes.has(new_node):
		active_autohide_nodes.append(new_node)
