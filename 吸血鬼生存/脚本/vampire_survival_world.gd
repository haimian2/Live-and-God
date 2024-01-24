extends Node2D

func _ready() -> void:
	$UI/StartUI.timer.start()
	get_tree().paused = true
