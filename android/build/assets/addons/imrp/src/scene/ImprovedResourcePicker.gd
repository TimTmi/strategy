@tool
extends ConfirmationDialog

@onready var tree : Tree = $VBoxContainer/Tree

var native : PopupMenu
var schemas = []


func decorate(_native: PopupMenu):
	
	native = _native
	schemas = []
	
	var rest_options_idx = -1
	
	for i in range(native.get_item_count()):
		if native.get_item_id(i) < 0:
			rest_options_idx = i + 1
			break
			
		schemas.append(
			{
				"id": native.get_item_id(i),
				"text": native.get_item_text(i),
				"icon": native.get_item_icon(i),
				"tooltip": native.get_item_tooltip(i)
			}
		)
	
	for i in range(rest_options_idx, native.get_item_count()):
		var item_text = native.get_item_text(i)
		var item_id = str(native.get_item_id(i))
		if item_text.is_empty():
			continue
		var btn = add_button(item_text, true, item_id)
		btn.icon = native.get_item_icon(i)
	
	var cancel_btn = get_cancel_button()
	remove_button(cancel_btn)
	add_button(cancel_btn.text, true, "cancel")
	
	tree.build_from_schemas(schemas)


func _on_ExchangedResourcePicker_popup_hide():
	call_deferred("queue_free")


func _on_ExchangedResourcePicker_confirmed():
	_handle_confirm()


func _on_LineEdit_text_changed(new_text: String):
	var filtered = []
	
	if new_text.is_empty():
		filtered = self.schemas
	else:
		for schema in self.schemas:
			if schema["text"].findn(new_text) > -1:
				filtered.append(schema)
	
	tree.build_from_schemas(filtered)


func _on_ExchangedResourcePicker_about_to_popup():
	$VBoxContainer/LineEdit.grab_focus.call_deferred()


func _on_Tree_item_double_clicked():
	_handle_confirm()


func _handle_confirm():
	assert(native != null)
	var id = tree.selected_schema_id()
	
	if id == -1:
		return
	
	native.id_pressed.emit(id)
	
	hide()


func _on_Tree_item_activated():
	_handle_confirm()


func _on_ExchangedResourcePicker_custom_action(action):
	hide()
	if action == "cancel":
		hide()
		return
	
	assert(native != null)
	var id = int(action)
	
	if id == -1:
		return
	
	native.id_pressed.emit(id)
	
	hide()
