extends CanvasLayer
class_name GameOverUI

@export var player:CharacterBody2D
@export var camera2d:Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var restart: Button = $PanelContainer/VBoxContainer/HBoxContainer/Restart
@onready var quit: Button = $PanelContainer/VBoxContainer/HBoxContainer/Quit

func _ready() -> void:
	player.player_died.connect(on_died)
	restart.pressed.connect(on_restart_pressed)
	quit.pressed.connect(on_quit_pressed)
	visible = false
	layer = -100

func on_died()->void:
	MetaProgression.save()
	
	visible = true
	layer = 100
	
	camera2d.global_position = player.get_node("Camera2D").global_position
	camera2d.scale = player.get_node("Camera2D").scale
	camera2d.enabled = true
	
	player.queue_free()
	get_tree().paused = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(self,"scale",Vector2.ZERO,0)
	tween.tween_property(self,"scale",Vector2.ONE,.3)	
	animation_player.play("淡入")

func on_restart_pressed() -> void:
	get_tree().paused = false
	SceneChanger.change_scene("res://吸血鬼生存/场景/vampire_survival_world.tscn",true)

func on_quit_pressed() -> void:
	get_tree().paused = false
	SceneChanger.change_scene("res://地图/场景/地图二.tscn",true)
