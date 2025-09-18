extends Label



func set_initials(character: Character):
	text = character.name.left(1)
	modulate = character.color
