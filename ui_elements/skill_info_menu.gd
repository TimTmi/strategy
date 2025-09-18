extends VBoxContainer

@export var skill_icon: TextureRect
@export var skill_name: Label
@export var skill_description: Label
@export var stats_container: GridContainer

func display_skill_info(skill: Skill) -> void:
	skill_icon.texture = skill.icon
	skill_name.text = skill.name
	skill_description.text = skill.description
	
	for i in stats_container.get_children():
		i.queue_free()
	
	for i in skill.stats:
		var name_label := Label.new()
		var value_label := Label.new()
		name_label.custom_minimum_size.x = 80
		name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		name_label.text = i
		value_label.text = str(skill.stats[i])
		stats_container.add_child(name_label)
		stats_container.add_child(value_label)
