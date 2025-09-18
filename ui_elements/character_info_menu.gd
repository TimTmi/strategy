extends VBoxContainer



const SKILL_BUTTON = preload("res://ui_elements/skill_button.tscn")
const HEALTH_SIZE: int = 8

var character: Character

signal skill_button_pressed(character: Character, skill: Skill)



func init(init_character: Character) -> void:
	character = init_character
	var max_health: float = character.health.maximum
	var current_health: float = character.health.current
	
	var name_display: TextureProgressBar = $VBoxContainer/Name
	name_display.get_node("Label").text = character.name
	name_display.custom_minimum_size.x = snappedf(name_display.size.x, 8)
	name_display.max_value = max_health
	name_display.value = current_health
	
	var health_bar: TextureProgressBar = $VBoxContainer/Health
	health_bar.custom_minimum_size.x = max_health * HEALTH_SIZE
	health_bar.max_value = max_health
	health_bar.value = current_health
	
	for i: Skill in character.skills.get_children():
		var skill_button: SkillButton = SKILL_BUTTON.instantiate()
		skill_button.icon = i.icon
		$Skills/HBoxContainer.add_child(skill_button)
		skill_button.pressed.connect(_on_skill_button_pressed.bind(character, i))

func _on_skill_button_pressed(character: Character, skill: Skill):
	skill_button_pressed.emit(character, skill)
