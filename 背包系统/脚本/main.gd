extends Node

@onready var player: Player = $"主角"
@onready var invenroty_interface: Control = $UI/InvenrotyInterface

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	invenroty_interface.set_player_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("equip_inventory_data"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(inventory_data = null)->void:
	invenroty_interface.visible = not invenroty_interface.visible
	if invenroty_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 

	if inventory_data:
		invenroty_interface.set_equip_inventory_data(inventory_data)
