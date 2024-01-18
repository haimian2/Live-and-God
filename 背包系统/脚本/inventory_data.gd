extends Resource
class_name InventoryData

signal Inventory_interact(inventory_data:InventoryData,index:int,button:int)
signal Inventory_updated(inventory_data:InventoryData)

@export var slot_datas:Array[SlotData] = []

const SLOT = preload("res://背包系统/场景/slot.tscn")

func on_slot_clicked(index:int,button:int) -> void:
	Inventory_interact.emit(self,index,button)

func grab_slot_data(index:int) -> SlotData:
	var slot_data = slot_datas[index]
	if slot_data.item_data.type != ItemData.ItemType.Nothing:
		slot_datas[index] = SlotData.new()
		Inventory_updated.emit(self)
		return slot_data
	else:
		return null
		
func drop_single_slot_data(grabbed_slot_data,index)->SlotData:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
	Inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null
		
func drop_slot_data(grabbed_slot_data:SlotData,index:int) -> SlotData:
	var slot_data = slot_datas[index]
	
	var return_slot_data:SlotData
	if slot_data.item_data.type != ItemData.ItemType.Nothing and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	elif slot_data.item_data.type != ItemData.ItemType.Nothing and slot_data.is_fully_merge_with(grabbed_slot_data):
		return_slot_data = slot_data.fully_merge_with_sub(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data 
		return_slot_data = null
	
	Inventory_updated.emit(self)
	return return_slot_data
