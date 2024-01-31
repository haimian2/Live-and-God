extends Node

@export var SWORD:PackedScene
@export var range_enemy_manager:RangeEnemyManager
@onready var timer: Timer = $Timer
@onready var player:CharacterBody2D = owner

var flash_sword_number:int = 1
var pickbox_radius:int = 50
var base_wait_time:float = 2
var base_flash_sword_damage:int = 10
var flash_sword_damage_percent:float = 0
	
func _ready() -> void:
	timer.wait_time = base_wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func _on_timer_timeout() -> void:
	if range_enemy_manager.latest_enemy_info.has("global_position"):
		var lastest_enemy_global_position:Vector2 = range_enemy_manager.latest_enemy_info["global_position"]
		var sword = SWORD.instantiate()
		var entities_layer = get_tree().get_first_node_in_group("foreground_layer")
		entities_layer.add_child(sword)
		sword.global_position = lastest_enemy_global_position
		sword.play_flash(base_flash_sword_damage * (1 + flash_sword_damage_percent))

func on_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	if upgrade.id == "sword_rate":
		var percent_reduction:float = current_upgrades["sword_rate"]["quantity"] * .1
		timer.wait_time = base_wait_time * (1 - percent_reduction)
		timer.start()
	elif upgrade.id == "sword_damage":
		flash_sword_damage_percent = current_upgrades["sword_damage"]["quantity"] * .1
