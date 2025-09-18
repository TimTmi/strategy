extends Button
class_name TimelinePoint



@export_range(0, 10, 1, "or_greater", "hide_slider") var max_decoration_count: int = 4

var animation_duration_add_decoration := 0.2
var animation_duration_remove_decoration := 0.2



func set_turn(turn: int):
	$Label.text = str(turn)

func add_decoration(decoration: Control) -> void:
	var container := $Decorations
	var decoration_count := container.get_child_count()
	#var modulate_step: int = 255 / (max_decoration_count + 1)
	
	if decoration_count >= max_decoration_count:
		return
	
	decoration.position = Vector2.DOWN * 8 * decoration_count
	decoration.size = Vector2(size.x - 1, 8)
	decoration.self_modulate.a = 0
	decoration.modulate.a = 1 - log(decoration_count + 1) / log(max_decoration_count + 1)
	
	container.add_child(decoration)
	
	create_tween().tween_property(decoration, "self_modulate:a", 1, animation_duration_add_decoration)

func remove_decoration(decoration: Control) -> void:
	var container := $Decorations
	
	if decoration.get_parent() != container:
		return
	
	var index := decoration.get_index()
	var last_index := container.get_child_count() - 1
	var remover_tween := create_tween()
	
	remover_tween.tween_property(decoration, "self_modulate:a", 0, animation_duration_remove_decoration)
	remover_tween.tween_interval(animation_duration_remove_decoration)
	remover_tween.set_parallel()
	for i: int in range(last_index, index, -1):
		var child = container.get_child(i)
		remover_tween.tween_property(child, "modulate:a", container.get_child(i - 1).modulate.a, animation_duration_remove_decoration)
		remover_tween.tween_property(child, "position:y", -8, animation_duration_remove_decoration).as_relative()
		container.get_child(i).modulate.a = container.get_child(i - 1).modulate.a
	
	remover_tween.tween_callback(decoration.queue_free)
