extends CharacterBody2D

@export var base_health:int = 100
@export var base_energy:int = 100
@export var base_damage:int = 10
@export var base_defense:int = 10
@export var base_magic:int = 100

@export var remainder:int = 10

@export var can_attack:bool = false
@export var is_unmatched:bool = false
@export var inventory_data:InventoryData
@export var inventory_data_equipped:InventoryData

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const jump_speed := -1200.0
const speed := 400
const FLOOR_ACCELERATION:float = speed / 0.1
const AIR_ACCELERATION:float = speed / 0.02
const JUMP_MOVE_SPEED = speed
const ROLL_SPEED:float = 600
var fall_speed:float = gravity * 0.6
var is_press_attack:bool = false
var interact_object:Object = null

var add_health:int = 0
var add_energy:int = 0
var add_damage:int = 0
var add_defense:int = 0
var add_magic:int = 0

var equip_health:int = 0
var equip_energy:int = 0
var equip_damage:int = 0
var equip_defense:int = 0
var equip_magic:int = 0

var cur_health:int = base_health + add_health
var cur_magic:int = base_magic + add_magic
var cur_energy:int = base_energy + add_energy
var level:int = 1
var money:int = 0

signal toggle_inventory()
signal change_money(value:int)
signal signal_change_equip_attribute(item_data:Resource)
signal object_to_inventory(resource:Resource)

func _enter_tree() -> void:
	inventory_data = InventoryData.new()
	inventory_data_equipped = InventoryData.new()
	for i in range(8):
		var slot_data = SlotData.new()
		inventory_data_equipped.slot_datas.push_back(slot_data)
	for i in range(6):
		for j in range(6):		
			var slot_data = SlotData.new()
			slot_data.item_data = ItemData.new()
			inventory_data.slot_datas.push_back(slot_data)

func _ready():
	change_money.connect(show_money_to_ui)
	object_to_inventory.connect(push_object_to_inventory)
	signal_change_equip_attribute.connect(change_euqip_attribute)
	get_node("HeroProperty/Health").max_value = base_health + add_health
	get_node("HeroProperty/Health").value = cur_health
	get_node("HeroProperty/Energy").max_value = base_energy + add_energy
	get_node("HeroProperty/Energy").value = cur_energy
	get_node("Interact/E_Key").visible = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	elif Input.is_action_just_pressed("interact_e"):
		if interact_object:
			if interact_object.has_signal("process_player_interact"):
				interact_object.process_player_interact.emit(self)

func change_euqip_attribute(item_data:Resource):
	if !item_data:
		equip_health = 0
		equip_magic = 0
		equip_energy = 0
		equip_damage = 0
		equip_defense = 0
	else:
		equip_health += item_data.add_health
		equip_magic += item_data.add_magic
		equip_energy += item_data.add_energy
		equip_damage += item_data.add_damage
		equip_defense += item_data.add_defense
	
func be_attack(value:int):
	if !is_unmatched:
		cur_health = cur_health - value
		get_node("HeroProperty/Health").value = cur_health	
		$FSM.change_state(3)
		
func process_E_KEY(Interact_obj:Node2D,value:bool):
	if value:
		interact_object = Interact_obj
	else:
		interact_object = null
	$Interact/E_Key.visible = value
	
func show_money_to_ui(value:int):
	money += value
	$MoneyUI/PanelContainer.show_money.emit()

func push_object_to_inventory(resource:SlotData):
	for i in inventory_data.slot_datas:
		if !i.item_data.texture:
			i.quantity = resource.quantity
			i.item_data = resource.item_data
			inventory_data.Inventory_updated.emit(inventory_data)
			return
