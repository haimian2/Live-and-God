extends PanelContainer

const Slot = preload("res://背包系统/场景/slot.tscn")

@onready var grid_container: GridContainer = $HBoxContainer/Shop/GridContainer

func set_inventory_data(inventory_data:InventoryData) -> void:
	inventory_data.Inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data:InventoryData)->void:
	for child in grid_container.get_children():
		child.queue_free()

	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		grid_container.add_child(slot)

		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			var item_data = slot_data.item_data
			slot.set_slot_data(slot_data)
