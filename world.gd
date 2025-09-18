extends Node2D



@export var physics_layer_controller: LayerController
@export var character_overlay: CharacterOverlay
@export var map: Map
@export var floor: TileMapLayer
@export var walls: TileMapLayer
@export var characters_container: Node2D
@export var trails_container: Node2D
@export var projectiles_container: Node2D
@export var event_manager: EventManager
@export var turn_handler: TurnHandler
@export var skill_input_handler: SkillInputHandler
@export var skill_input_preview: SkillInputPreview
@export var spawner: Spawner
@export var ui: UI
@export var mouse_input_getter: MouseInputGetter
@export var camera: Camera2D

var player_team: StringName = "team1"
var teams: Array = [
	TeamSetup.new("team1", Color.DODGER_BLUE,
	[CharacterSetup.new("elf", Vector2(56,232)), CharacterSetup.new("knight", Vector2(136,232))]),
	
	TeamSetup.new("team2", Color.RED,
	[CharacterSetup.new("elf", Vector2(56,152)), CharacterSetup.new("knight", Vector2(136,152))])
]



signal setup_finished
signal turn_started
signal turn_ended
signal turn_changed
signal game_ended



func _ready():
	#Engine.time_scale = 0.1
	
	physics_layer_controller.add_layer("environment")
	
	floor.z_index = RenderLayers.FLOOR
	walls.z_index = RenderLayers.WALLS
	characters_container.z_index = RenderLayers.CHARACTERS
	trails_container.z_index = RenderLayers.TRAILS
	projectiles_container.z_index = RenderLayers.PROJECTILES
	character_overlay.z_index = RenderLayers.UI
	skill_input_handler.z_index = RenderLayers.UI
	skill_input_preview.z_index = RenderLayers.UI
	
	skill_input_handler.skill_input_preview = skill_input_preview
	mouse_input_getter.map = map
	
	spawner.characters_container = characters_container
	spawner.projectiles_container = projectiles_container
	spawner.trails_container = trails_container
	
	spawner.character_spawned.connect(_on_character_spawned)
	
	walls.tile_set.set_physics_layer_collision_layer(0, physics_layer_controller.get_layer_bitmask("environment", ["statics"]))
	walls.tile_set.set_physics_layer_collision_mask(0, physics_layer_controller.get_layer_bitmask("environment", [], true))
	
	ui.facade.character_selected.connect(character_overlay.show_character_overlay, CONNECT_DEFERRED)
	ui.facade.character_menu_hidden.connect(character_overlay.hide)
	
	for team_setup: TeamSetup in teams:
		physics_layer_controller.add_layer(team_setup.name)
		for character_setup: CharacterSetup in team_setup.characters:
			var character: Character = load("res://characters/%s.tscn" %character_setup.name).instantiate()
			
			character.add_to_group("characters")
			character.add_to_group(team_setup.name)
			
			spawner.spawn_character(character)
			#character.button.pressed.connect(_on_character_pressed.bind(character))
			#add_child(character, true)
			
			character.team = team_setup.name
			character.position = character_setup.position
			character.collision_layer = physics_layer_controller.get_layer_bitmask(team_setup.name, ["characters"])
			character.collision_mask = physics_layer_controller.get_layer_bitmask(team_setup.name, [], true)
			character.color = team_setup.color.lightened(0.3)
			
			event_manager.add_event(Event.new(turn_handler.start_turn.bind(character), turn_ended, [character]), 0)
	
	setup_finished.emit()
	
	event_manager.start_next_event()

func _on_turn_started(_character: Character):
	#if (character.team == player_team):
		#toggle_UI(true)
	toggle_UI(true)

func _on_turn_ended(turns_used: int):
	event_manager.add_event(
		Event.new(
			turn_handler.start_turn.bind(turn_handler.current_character),
			turn_ended,
			[turn_handler.current_character]
		),
		turns_used
	)
	turn_ended.emit()

func set_object_button_visibility(enable: bool):
	for i: Node in get_tree().get_nodes_in_group("touchableObjects"):
		i.get_node("Button").visible = enable

func toggle_UI(enable: bool):
	set_object_button_visibility(enable)
	ui.visible = enable

func get_skill_inputs(skill: Skill) -> bool:
	for i in skill.inputs.size():
		var skill_input: SkillInput = skill.inputs[i]
		var instruction: InputInstruction = skill_input.get_instruction()
		var input: Variant = await skill_input_handler.get_skill_input(instruction)
		if input == null:
			return false
		skill_input.data = input
	return true

func use_skill(skill: Skill):
	set_object_button_visibility(false)
	
	var successful: bool = await get_skill_inputs(skill)
	if not successful:
		set_object_button_visibility(true)
		return
	
	var accepted: bool = await ui.facade.confirm_skill(event_manager.turn,  skill.get_used_turn())
	skill_input_preview.stop_preview()
	if accepted:
		await skill.use()
	#else:
		#skill.clear_inputs()
	
	set_object_button_visibility(true)

#func confirm_skill(skill: Skill):
	#var used_turn: int = skill.get_used_turn()
	#if used_turn == -1:
		#return
	#
	#ui.event_timeline_view.mark_turn(event_manager.clamp_turn(event_manager.turn + used_turn))
	#ui.skill_confirm.show()
	#var accepted: bool = await ui.skill_confirm.decision_made
	#ui.event_timeline_view.unmark_turn()
	#ui.skill_confirm.hide()
	#return accepted

func _on_character_spawned(character: Character) -> void:
	#characters_container.add_child(character, true)
	character.button.released.connect(_on_character_pressed.bind(character))
	character.spawner = spawner
	
	#for i: Skill in character.skills.get_children():
		#i.request_spawn_character.connect(spawn_character)
		#i.request_spawn_projectile.connect($Map/Projectiles.add_child)
	#
	#for i: Ability in character.abilities.get_children():
		#i.request_spawn_character.connect(spawn_character)
		#i.request_spawn_projectile.connect($Map/Projectiles.add_child)

func _on_character_pressed(character: Character):
	ui.facade.show_character_menu(character)

func world_to_UI(world_position: Vector2) -> Vector2:
	return ui.size * 0.5 + world_position - camera.global_position

func _on_character_skill_chosen(character: Character, skill: Skill) -> void:
	if character == turn_handler.current_character:
		use_skill(skill)
	else:
		var skill_info_menu := $CanvasLayer/UI/InputOutput/SkillInfo
		ui.show_node(skill_info_menu)
		skill_info_menu.display_skill_info(skill)
