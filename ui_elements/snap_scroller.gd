@tool
class_name SnapScroller extends Control



@export var container: Control:
	set(value):
		container = value
		if Engine.is_editor_hint():
			update_configuration_warnings()

@export_group("Dragging")
@export var damping: float = 0.2
@export var velocity_threshold: float = 6
@export_range(0, 1, 0.01) var snap_threshold_percent: float = 0.2

var snapped_index: int = 0:
	set(value):
		if value == snapped_index:
			return
		snapped_index = value
		snapped_index_changed.emit(snapped_index)

var dragging: bool
var press_position: float
var drag_distance: float
var drag_velocity: float = 0
var tween: Tween



signal scroll_finished
signal snap_finished
signal snapped_index_changed



class NodeOffset:
	var node: Control
	var offset: float
	
	func _init(init_node: Control, init_offset: float) -> void:
		node = init_node
		offset = init_offset



func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	if not container:
		warnings.append("Requires a child Control to work properly.")
	
	return warnings

func _ready() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if abs(drag_velocity) < velocity_threshold:
		scroll_finished.emit()
		
		var snap_threshold_px: float = size.x * snap_threshold_percent
		prints(drag_distance, snap_threshold_px)
		var closest_node_offset: NodeOffset = _get_closest_node_offset(abs(drag_distance) >= snap_threshold_px)
		snapped_index = closest_node_offset.node.get_index()
		_snap(-closest_node_offset.offset)
		
		set_physics_process(false)
	
	container.position.x += drag_velocity
	drag_velocity = lerpf(drag_velocity, 0, damping)
#
func _gui_input(event: InputEvent) -> void:
	if not container:
		return
	
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
		
		dragging = event.pressed
		
		if dragging:
			set_physics_process(false)
			press_position = event.position.x
			if tween:
				tween.kill()
		else:
			drag_distance = event.position.x - press_position
			set_physics_process(true)
	
	elif event is InputEventMouseMotion and dragging:
		var relative = event.relative.x
		container.position.x += relative
		drag_velocity = relative

func _get_closest_node_offset(exclude_current_node: bool = false) -> NodeOffset:
	print(exclude_current_node)
	var center: float = size.x * 0.5
	var container_position: float = container.position.x
	var closest_node: Control = null
	var min_offset: float = INF
	var current_node: Control = container.get_child(snapped_index)
	
	if container.get_child_count() == 0:
		return NodeOffset.new(null, 0)
	
	var nodes: Array[Node] = container.get_children()
	nodes = nodes.filter(func(node: Node): return node is Control)
	
	if exclude_current_node and nodes.size() > 1:
		nodes.erase(current_node)
	
	for node: Control in nodes:
		var node_center: float = container_position + node.position.x + node.size.x * 0.5
		var offset: float = node_center - center
		if abs(offset) < abs(min_offset):
			closest_node = node
			min_offset = offset
	
	return NodeOffset.new(closest_node, min_offset)

func _snap(relative_x: float) -> void:
	if tween:
		tween.kill()
	
	var tween_duration: float = 0.3
	tween = create_tween()
	tween.tween_property(container, "position:x", relative_x, tween_duration).as_relative().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(snap_finished.emit)

func go_to_first_node(emit_snap_signal: bool = false) -> void:
	var node: Control = container.get_child(0)
	container.position.x = size.x * 0.5 - (node.position.x + node.size.x * 0.5)
	
	if emit_snap_signal:
		snap_finished.emit()
