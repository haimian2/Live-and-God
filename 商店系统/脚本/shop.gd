extends Node2D

signal process_player_interact(player:Object)
signal signal_buy_item(player:Object)
signal signal_update_item(palyer:Object)
signal signal_sell_item(player:Object)

var shopInventory:InventoryData
@onready var shop_inventory_interface: PanelContainer = $ShopUI/ShopInventoryInterface

func _ready() -> void:
	process_player_interact.connect(process_interact)
	shop_inventory_interface.visible = false
	signal_buy_item.connect(buy_item)
	signal_update_item.connect(update_item)
	signal_sell_item.connect(sell_item)
	initialize_shop_item()

func process_interact(player:Object)->void:
	shop_inventory_interface.visible = !shop_inventory_interface.visible
	
func initialize_shop_item()->void:
	pass
	
func update_item(player:Object)->void:
	pass
	
func buy_item(player:Object)->void:
	pass

func sell_item(player:Object)->void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_E_KEY(self,true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		shop_inventory_interface.visible = false
		body.process_E_KEY(self,false)
