class_name CharacterMenu extends Button



const CHARACTER_INFO_MENU: PackedScene = preload("res://ui_elements/character_info_menu.tscn")

@export_group("Dragging")
@export var damping: float = 0.2
@export var velocity_threshold: float = 6
@export var menu_switch_drag_distance: float = 64

@onready var hbox: HBoxContainer = $HBoxContainer

var press_position: float
var drag_distance: float
var drag_velocity: float = 0
var tween: Tween

var snap_index: int
var current_index: int = 0:
	set(value):
		current_index = clampi(value, 0, hbox.get_child_count() - 1)
		character_changed.emit(hbox.get_child(current_index).character)

signal character_skill_chosen(character: Character, skill: Skill)
signal character_changed(character: Character)



func _ready() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if abs(drag_velocity) < velocity_threshold:
		if current_index == snap_index && abs(drag_distance) >= menu_switch_drag_distance:
			current_index = current_index - sign(drag_distance)
		else:
			current_index = snap_index
		_snap_to_position(_get_menu_position(current_index))
		set_physics_process(false)
	
	hbox.position.x += drag_velocity
	drag_velocity = lerpf(drag_velocity, 0, damping)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			set_physics_process(false)
			press_position = event.position.x
			if tween:
				tween.kill()
		else:
			set_physics_process(true)
			drag_distance = event.position.x - press_position
	
	elif event is InputEventScreenDrag:
		if event.index != 0:
			return
		var relative = event.relative.x
		hbox.position.x += relative
		drag_velocity = relative

func _on_visibility_changed() -> void:
	if visible:
		current_index = 0
		hbox.position.x = 0
	
	else:
		for i in hbox.get_children():
			i.queue_free()

func _get_menu_position(menu_index: int) -> float:
	var step: float = hbox.get_child(0).size.x + hbox.get_theme_constant("separation")
	return menu_index * -step

func _snap_to_position(snap_position: float) -> void:
	if tween:
		tween.kill()
	
	var tween_duration: float = 0.3
	tween = create_tween()
	tween.tween_property(hbox, "position:x", snap_position, tween_duration).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)

func _on_skill_button_pressed(character: Character, skill: Skill):
	hide()
	character_skill_chosen.emit(character, skill)

func _on_character_menu_visible_on_screen(menu_index: int):
	snap_index = menu_index

func add_character(character: Character) -> void:
	var character_info_menu = CHARACTER_INFO_MENU.instantiate()
	character_info_menu.init(character)
	character_info_menu.skill_button_pressed.connect(_on_skill_button_pressed)
	hbox.add_child(character_info_menu)
	character_info_menu.get_node("VisibleOnScreenNotifier2D").screen_entered.connect(_on_character_menu_visible_on_screen.bind(character_info_menu.get_index()))
