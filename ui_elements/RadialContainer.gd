extends Container
class_name RadialContainer


@export var start_angle: float = -PI*0.5
@export var radius: int = 24


func _ready():
	sort_children.connect(_on_sort_children)

func _on_sort_children():
	var center: Vector2 = get_rect().size * 0.5
	var children: Array[Node] = get_children()
	var children_count: int = children.size()
	var angle = PI * 2 / children_count
	for i in children_count:
		var child = children[i]
		if not (child is Node2D or child is Control):
			continue
		var child_offset = child.size * 0.5
		child.position = center + (Vector2.RIGHT * radius).rotated(i * angle + start_angle) - child_offset
