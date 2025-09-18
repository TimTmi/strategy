@tool
extends EditorPlugin


const ExchangedResourcePicker = preload(
	"res://addons/imrp/src/scene/ImprovedResourcePicker.tscn"
)


func _enter_tree():
	var editor_tree = get_editor_interface().get_base_control().get_tree()
	editor_tree.node_added.connect(_on_node_added)


func _exit_tree():
	var editor_tree = get_editor_interface().get_base_control().get_tree()
	editor_tree.node_added.disconnect(_on_node_added)


func _on_node_added(node : Node):
	if node.is_class("PopupMenu") and node.get_parent().is_class("EditorResourcePicker"):
		node.about_to_popup.connect(_on_native_picker_show.bind(node))


func _on_native_picker_show(native_picker: PopupMenu):
	native_picker.hide.call_deferred()
	var ex_picker = ExchangedResourcePicker.instantiate()
	get_editor_interface().get_base_control().get_viewport().add_child(ex_picker)
	ex_picker.decorate(native_picker)
	ex_picker.popup_centered()
