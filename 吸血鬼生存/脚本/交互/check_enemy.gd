extends Area2D

@export var range_enemy_manager:RangeEnemyManager

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
func on_body_entered(body:Node2D):
	if body.is_in_group("monster"):
		range_enemy_manager.add_enemy(body)

func on_body_exited(body:Node2D):
	if body.is_in_group("monster"):
		range_enemy_manager.remove_enemy(body)
