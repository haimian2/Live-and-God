extends Node

@onready var backpack: Control = $Backpack

var player

func _enter_tree() -> void:
	player = owner.get_node("Hero")

func _ready() -> void:
	if !player:
		print("玩家未找到")
		return
	player.toggle_inventory.connect(toggle_inventory_interface)
	backpack.set_player_inventory_data(player.inventory_data)
	backpack.set_equip_inventory_data(player.inventory_data_equipped)

func toggle_inventory_interface(inventory_data = null)->void:
	backpack.visible = not backpack.visible
	if backpack.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
#
	#if inventory_data:
		#invenroty_interface.set_equip_inventory_data(inventory_data)
