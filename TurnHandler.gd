class_name TurnHandler extends Node


var current_character: Character



signal turn_started(Character)
signal turn_ended(int)



func start_turn(character: Character):
	current_character = character
	var unhighlight = character.highlight()
	
	character.turn_ended.connect(_on_character_turn_ended, CONNECT_ONE_SHOT)
	turn_ended.connect(func(_turns_used: int): unhighlight.call(), CONNECT_ONE_SHOT)
	
	character.start_turn()
	turn_started.emit(character)

func _on_character_turn_ended(turns_used: int):
	turn_ended.emit(turns_used)
