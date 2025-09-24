extends VBoxContainer



const SKILL_BUTTON = preload("res://ui_elements/skill_button.tscn")
const HEALTH_SIZE: int = 8
const NAME_BAR_EXPAND_MARGIN: int = 2

var character: Character

signal skill_button_pressed(character: Character, skill: Skill)



func _on_skill_button_pressed(skill: Skill):
	skill_button_pressed.emit(character, skill)

func _setup_name_display(name_display, name_label, current_health) -> void:
	name_label.text = character.name
	name_display.value = current_health
	
	var foo: Callable = func():
		var name_bar_length: float = name_label.size.x + NAME_BAR_EXPAND_MARGIN * 2
		name_display.custom_minimum_size.x = name_bar_length
		name_display.max_value = name_bar_length
	
	foo.call_deferred()

func init(init_character: Character) -> void:
	character = init_character
	
	var name_display: TextureProgressBar = $CenterContainer/VBoxContainer/Name
	var name_label: Label = $CenterContainer/VBoxContainer/Name/CenterContainer/Label
	var health_bar: TextureProgressBar = $CenterContainer/VBoxContainer/Health
	
	var max_health: float = character.health.maximum * HEALTH_SIZE
	var current_health: float = character.health.current * HEALTH_SIZE
	
	_setup_name_display(name_display, name_label, current_health)
	
	health_bar.custom_minimum_size.x = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	
	for i: Skill in character.skills.get_children():
		var skill_button: SkillButton = SKILL_BUTTON.instantiate()
		skill_button.icon = i.icon
		$Skills/HBoxContainer.add_child(skill_button)
		skill_button.pressed.connect(_on_skill_button_pressed.bind(i))
