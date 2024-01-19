extends CanvasLayer

signal upgrade_selected(upgrade:AbilityUpgrade)

@export var upgrade_card_scene:PackedScene

@onready var card_container:HBoxContainer = $%CardContainer

func _ready() -> void:
	get_tree().paused = true

func set_ability_upgrade(upgrades:Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_card_selected.bind(upgrade))
		
func on_card_selected(upgrade:AbilityUpgrade)->void:
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
