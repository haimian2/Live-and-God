extends Control

var grabbed_slot_data:SlotData

@onready var player: Player = owner.player

@onready var grabbed_slot: PanelContainer = $GrabbedSlot
@onready var equip_inventory: PanelContainer = $HBoxContainer/EquipInventory
@onready var player_inventory: PanelContainer = $HBoxContainer/PlayerInventory

var typearr : Array[ItemData.ItemType] = [ItemData.ItemType.Head,ItemData.ItemType.Attack,ItemData.ItemType.Chest,\
					ItemData.ItemType.Defense,ItemData.ItemType.Leg,ItemData.ItemType.Ring,ItemData.ItemType.Shoe,ItemData.ItemType.Ring]

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.set_background_visible()
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5,5)
		
func set_player_inventory_data(inventory_data:InventoryData) -> void:
	inventory_data.Inventory_interact.connect(on_Inventory_interact)
	player_inventory.set_inventory_data(inventory_data)

func set_equip_inventory_data(inventory_data:InventoryData) -> void:
	inventory_data.Inventory_interact.connect(on_Equipment_Interact)
	equip_inventory.set_inventory_data(inventory_data)
	
func on_Inventory_interact(inventory_data:InventoryData,index:int,button:int):
	match [grabbed_slot_data,button]:
		[null,MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_,MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data,index)
		[null,MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_,MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data,index)
	update_grabbed_slot()

func on_Equipment_Interact(inventory_data:InventoryData,index:int,button:int):
	match [grabbed_slot_data,button]:
		[null,MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_,MOUSE_BUTTON_LEFT]:
			if grabbed_slot_data.item_data and grabbed_slot_data.item_data.type == typearr[index]:
				grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data,index)
		[null,MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_,MOUSE_BUTTON_RIGHT]:
			if grabbed_slot_data.item_data and grabbed_slot_data.item_data.type == typearr[index]:
				grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data,index)
	update_grabbed_slot()
	

func update_grabbed_slot()->void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
