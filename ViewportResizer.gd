extends Node


@export var node: Control

@onready var viewport_height = get_viewport().size.y


func _ready():
	set_process(false)

func run():
	pass
	#set_process(true)

func stop():
	set_process(false)
	node.size.y = viewport_height * 0.2

func _process(_delta):
	node.size.y = (viewport_height - DisplayServer.virtual_keyboard_get_height()) * 0.2
