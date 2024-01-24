extends CanvasLayer

signal upgrade_selected(upgrade:AbilityUpgrade)

@export var upgrade_card_scene:PackedScene

@onready var card_container:HBoxContainer = $%CardContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	get_tree().paused = true

func set_ability_upgrade(upgrades:Array[AbilityUpgrade]):
	var delay:float = 0.0
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		animation_player.play("淡入")
		card_instance.play_in(delay)
		card_instance.selected.connect(on_card_selected.bind(upgrade))
		delay += 0.25
		
func on_card_selected(upgrade:AbilityUpgrade)->void:
	upgrade_selected.emit(upgrade)
	animation_player.play("淡出")
	await animation_player.animation_finished
	get_tree().paused = false
	queue_free()
