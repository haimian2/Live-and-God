extends CanvasLayer
class_name GameOverUI

signal player_died(player:Node2D)

func _ready() -> void:
	player_died.connect(process_player_died)

func process_player_died(player:Node2D)->void:
	visible = true
	player.visible = false
	get_tree().paused = true

func _on_button_pressed() -> void:
	SceneChanger.change_scene("res://吸血鬼生存/场景/vampire_survival_world.tscn",true)

func _on_button_2_pressed() -> void:
	SceneChanger.change_scene("res://地图/场景/地图二.tscn",true)
