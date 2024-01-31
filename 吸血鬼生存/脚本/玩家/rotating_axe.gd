extends Node

@export var AXE:PackedScene
@onready var timer: Timer = $Timer

var base_wait_time:float = 4
var rotating_axe_damage_percent:float

func _ready() -> void:
	timer.wait_time = base_wait_time
	timer.start()
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func _on_timer_timeout() -> void:
	var axe = AXE.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("foreground_layer")
	entities_layer.add_child(axe)
	axe.play_rotation()

func on_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	if upgrade.id == "axe_rate":
		var percent_reduction:float = current_upgrades["axe_rate"]["quantity"] * .1
		timer.wait_time = base_wait_time * (1 - percent_reduction)
		timer.start()
	elif upgrade.id == "axe_damage":
		rotating_axe_damage_percent = current_upgrades["axe_damage"]["quantity"] * .1
