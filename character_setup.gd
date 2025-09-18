extends Resource
class_name CharacterSetup



var name: StringName = "knight"
var position: Vector2 = Vector2.ZERO
#func _init(data: String = "knight.0:0"):
	#var properties: PackedStringArray = ["character_name", "character_position"]
	#for i in data.split(".", false, properties.size()):
		
func _init(init_name: StringName = "character", init_position: Vector2 = Vector2.ZERO):
	name = init_name
	position = init_position
