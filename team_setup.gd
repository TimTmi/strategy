extends Resource
class_name TeamSetup



var name: StringName
var color: Color
var characters: Array[CharacterSetup]



func _init(init_name: StringName = "team0", init_color: Color = Color(), init_characters: Array[CharacterSetup] = []):
	name = init_name
	color = init_color
	characters = init_characters
