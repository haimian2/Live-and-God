extends Node2D

@onready var area_2d: Area2D = $Sprite2D/Area2D
var exe:int = 1

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.interact_experience.emit(exe)
		queue_free()


func _on_timer_timeout() -> void:
	area_2d.monitorable = true
	area_2d.monitoring = true
