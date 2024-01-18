extends Resource
class_name  SlotData

const MAX_STACK_SIZE:int = 99
@export var item_data:ItemData = ItemData.new()
@export_range(1,MAX_STACK_SIZE) var quantity:int = 1 : set = set_quantity

func can_merge_with(other_slot_data:SlotData)->bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity < MAX_STACK_SIZE

func can_fully_merge_with(other_slot_data:SlotData)->bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity + other_slot_data.quantity < MAX_STACK_SIZE

func is_fully_merge_with(other_slot_data:SlotData)->bool:
	return item_data == other_slot_data.item_data and quantity + other_slot_data.quantity >= MAX_STACK_SIZE
	
func fully_merge_with_sub(other_slot_data:SlotData)-> SlotData:
	other_slot_data.quantity = quantity + other_slot_data.quantity - MAX_STACK_SIZE
	quantity = MAX_STACK_SIZE
	if other_slot_data.quantity == 0:
		return null
	else:
		return other_slot_data

func fully_merge_with(other_slot_data:SlotData)->void:
	quantity += other_slot_data.quantity
	
func create_single_slot_data()->SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data

func set_quantity(value:int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("%s不可堆叠,设置数量为1" % item_data.name)
