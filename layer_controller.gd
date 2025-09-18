class_name LayerController extends Resource



@export var available_sublayers: PackedStringArray

var layers: Dictionary = {}
var next_available_layer: int = 0

#@onready var get_layer_size(): int = available_sublayers.size()




func get_layer_size() -> int:
	return available_sublayers.size()

func get_layer_bitmask(layer: StringName, target_sublayers: PackedStringArray = [], invert: bool = false) -> int:
	var sublayers: int = 0
	if target_sublayers.is_empty():
		sublayers = (1 << get_layer_size()) - 1
	else:
		for i: String in target_sublayers:
			var sublayer: int = available_sublayers.find(i)
			if sublayer == -1:
				continue
			sublayers |= 1 << sublayer
	var bitmask: int = sublayers << layers[layer]
	return (1 << 32) - 1 - bitmask if invert else bitmask

func add_layer(layer_name: StringName) -> bool:
	if next_available_layer + get_layer_size() > 32:
		return false
	layers[layer_name] = next_available_layer
	next_available_layer += get_layer_size()
	return true

func remove_layer(layer_name: StringName) -> bool:
	return layers.erase(layer_name)
