extends Node

const SWORD = preload("res://吸血鬼生存/场景/sword.tscn")
@onready var timer: Timer = $Timer

var number:int = 1
var distanse:int = 200
var waitime:int = 3

func flash_attack()->void:
	pass
	
func _ready() -> void:
	timer.wait_time = waitime

func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("monster")
	enemies = enemies.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(owner.global_position) < pow(distanse,2)
	)
	if enemies.is_empty():
		return
	enemies.sort_custom(func(a:Node2D,b:Node2D):
		var a_distance = a.global_position.distance_squared_to(owner.global_position)
		var b_distance = b.global_position.distance_squared_to(owner.global_position)
		return a_distance < b_distance
	)
	for i in range(0,number):
		var sword = SWORD.instantiate()
		owner.get_node("FlashObject").add_child(sword)
		sword.global_position = enemies[i].global_position + (owner.global_position - enemies[i].global_position).normalized() * 2
		sword.flash_attack()
