extends Node

@export var experience_manager:Node
@export var upgrade_screen_scene:PackedScene
const AXE = preload("res://吸血鬼生存/场景/升级/Axe.tres")
const AXE_DAMAGE = preload("res://吸血鬼生存/场景/升级/AxeDamage.tres")
const AXE_RATE = preload("res://吸血鬼生存/场景/升级/AxeRate.tres")
const SWORD_DAMAGE = preload("res://吸血鬼生存/场景/升级/SwordDamage.tres")
const SWORD_RATE = preload("res://吸血鬼生存/场景/升级/SwordRate.tres")
const PLAYER_SPEED = preload("res://吸血鬼生存/场景/升级/PlayerSpeed.tres")
var upgrade_pool:WeightTable = WeightTable.new()
var current_upgrades = {}

func _ready() -> void:
	upgrade_pool.add_item(AXE,10)
	upgrade_pool.add_item(SWORD_DAMAGE,10)
	upgrade_pool.add_item(SWORD_RATE,10)
	upgrade_pool.add_item(PLAYER_SPEED,10)	
	experience_manager.level_up.connect(on_level_up)
	
func update_upgrade_pool(chosen_upgrade:AbilityUpgrade):
	if chosen_upgrade.id == AXE.id:
		upgrade_pool.add_item(AXE_DAMAGE,10)
		upgrade_pool.add_item(AXE_RATE,10)
	
func apply_upgrade(upgrade:AbilityUpgrade)->void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource":upgrade,
			"quantity":1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity >= upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)

	GameEvents.emit_ability_upgrade_added(upgrade,current_upgrades)
	
func pick_upgrades()->Array[AbilityUpgrade]:
	var chosen_upgrades:Array[AbilityUpgrade] = []
	for i in 3:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades)
		chosen_upgrades.append(chosen_upgrade)
	return chosen_upgrades
	
func on_level_up(new_level:int)->void:
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrade(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	
func on_upgrade_selected(upgrade:AbilityUpgrade)->void:
	apply_upgrade(upgrade)
