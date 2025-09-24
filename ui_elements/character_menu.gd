@tool
class_name CharacterMenu extends SnapScroller



const CHARACTER_INFO_MENU: PackedScene = preload("res://ui_elements/character_info_menu.tscn")

signal skill_chosen(character: Character, skill: Skill)
signal character_selected(character: Character)



func _ready() -> void:
	super._ready()
	
	if Engine.is_editor_hint():
		return
	
	snap_finished.connect(func(): character_selected.emit(container.get_child(snapped_index).character))

func _on_visibility_changed() -> void:
	if Engine.is_editor_hint():
		return
	
	if visible:
		go_to_first_node.call_deferred(true)
	
	else:
		for i in container.get_children():
			i.queue_free()

func _on_skill_button_pressed(character: Character, skill: Skill):
	hide()
	skill_chosen.emit(character, skill)

func add_character(character: Character) -> void:
	var character_info_menu = CHARACTER_INFO_MENU.instantiate()
	character_info_menu.init(character)
	character_info_menu.skill_button_pressed.connect(_on_skill_button_pressed)
	container.add_child(character_info_menu)
