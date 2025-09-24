class_name UIFacade extends Node



@export var character_menu: CharacterMenu
@export var event_timeline_view: TimelineView
@export var skill_confirm: ActionBar
@export var text_output: Button
@export var skill_info_menu: SkillInfoMenu



signal character_menu_character_selected(character: Character)
signal character_menu_hidden()
signal character_menu_skill_chosen(character: Character, skill: Skill)



func _ready() -> void:
	character_menu.character_selected.connect(func(character: Character): character_menu_character_selected.emit(character))
	character_menu.hidden.connect(func(): character_menu_hidden.emit())
	character_menu.skill_chosen.connect(func(character: Character, skill: Skill): character_menu_skill_chosen.emit(character, skill))

func _show_node(node: Control) -> void:
	node.show()
	node.grab_focus()

func display_message(text: String):
	text_output.text = text
	_show_node(text_output)

func show_character_menu(character: Character) -> void:
	character_menu.add_character(character)
	_show_node(character_menu)

func show_skill_info_menu(skill: Skill) -> void:
	_show_node(skill_info_menu)
	skill_info_menu.display_skill_info(skill)

func confirm_skill(current_turn: int, used_turn: int):
	if used_turn == -1:
		return
	
	event_timeline_view.mark_turn(current_turn + used_turn)
	skill_confirm.show()
	var accepted: bool = await skill_confirm.decision_made
	event_timeline_view.unmark_turn()
	skill_confirm.hide()
	return accepted
