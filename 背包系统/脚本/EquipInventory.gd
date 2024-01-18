extends PanelContainer

signal change_attribute_text()

const Slot = preload("res://背包系统/场景/slot.tscn")

@onready var player: Player = owner.player
@onready var item_grid: GridContainer = $MarginContainer/GridContainer

func set_inventory_data(inventory_data:InventoryData) -> void:
	inventory_data.Inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data:InventoryData)->void:
	for child in item_grid.get_children():
		child.queue_free()
		
	player.signal_change_equip_attribute.emit(null)
						
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)

		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			var item_data = slot_data.item_data
			player.signal_change_equip_attribute.emit(item_data)
			slot.set_slot_data(slot_data)
			change_attribute_text.emit()
