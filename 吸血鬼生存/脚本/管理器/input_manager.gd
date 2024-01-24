extends Node

@export var main_menu:CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_menu"):
		if main_menu.visible:
			main_menu.visible = false
			main_menu.layer = -100
			get_tree().paused = false
		else:
			main_menu.visible = true
			main_menu.layer = 100
			get_tree().paused = true
