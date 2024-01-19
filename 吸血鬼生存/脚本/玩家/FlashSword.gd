extends Node

const SWORD = preload("res://吸血鬼生存/场景/玩家/sword.tscn")
@onready var timer: Timer = $Timer
@onready var player:CharacterBody2D = owner

var flash_sword_number:int = 1
var pickbox_radius:int = 50
var hitbox_radius:int = 200
var base_wait_time:float = 1.5

func flash_attack()->void:
	pass
	
func _ready() -> void:
	timer.wait_time = base_wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("monster")
	enemies = enemies.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(hitbox_radius,2)
	)
	if enemies.is_empty():
		return
	enemies.sort_custom(func(a:Node2D,b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	for i in range(0,flash_sword_number):
		var sword = SWORD.instantiate()
		player.get_parent().add_child(sword)
		sword.global_position = enemies[i].global_position + (player.global_position - enemies[i].global_position).normalized() * 2
		sword.play_flash()

func on_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	if upgrade.id != "sword_rate":
		return
	var percent_reduction:float = current_upgrades["sword_rate"]["quantity"] * .1
	timer.wait_time = base_wait_time * (1 - percent_reduction)
	timer.start()
	print(timer.wait_time)
