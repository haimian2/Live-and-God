extends PanelContainer

@onready var player: Player = owner.player

func set_text() -> void:
	$MarginContainer/GridContainer/MarginContainer2/GridContainer/Label2.text = type_convert(player\
								.base_health + player.add_health + player.equip_health,TYPE_STRING)
	$MarginContainer/GridContainer/MarginContainer3/GridContainer/Label2.text = type_convert(player\
								.base_magic + player.add_magic + player.equip_magic,TYPE_STRING)
	$MarginContainer/GridContainer/MarginContainer4/GridContainer/Label2.text = type_convert(player\
								.base_damage + player.add_damage + player.equip_damage,TYPE_STRING)
	$MarginContainer/GridContainer/MarginContainer5/GridContainer/Label2.text = type_convert(player\
								.base_defense + player.add_defense + player.equip_defense,TYPE_STRING)
	$MarginContainer/GridContainer/MarginContainer6/GridContainer/Label2.text = type_convert(player\
								.base_energy + player.add_energy + player.equip_energy,TYPE_STRING)
	$MarginContainer/GridContainer/MarginContainer7/GridContainer/Label2.text = type_convert(player\
								.remainder,TYPE_STRING)

func _ready() -> void:
	$"../EquipInventory".change_attribute_text.connect(set_text)
	set_text()

func _on_texture_button_pressed_hp() -> void:
	if player.remainder <= 0:
		return
	player.add_health += 1
	player.remainder -= 1
	set_text()

func _on_texture_button_pressed_energy() -> void:
	if player.remainder <= 0:
		return
	player.add_energy += 1
	player.remainder -= 1
	set_text()
	
func _on_texture_button_pressed_damage() -> void:
	if player.remainder <= 0:
		return
	player.add_damage += 1
	player.remainder -= 1
	set_text()
	
func _on_texture_button_pressed_defense() -> void:
	if player.remainder <= 0:
		return
	player.add_defense += 1
	player.remainder -= 1
	set_text()
	
func _on_texture_button_pressed_magic() -> void:
	if player.remainder <= 0:
		return
	player.add_magic += 1
	player.remainder -= 1
	set_text()

func _on_texture_button_pressed_reset() -> void:
	player.remainder += player.add_damage + player.add_defense + player.add_energy + player.add_health + player.add_magic
	player.add_damage = 0
	player.add_defense = 0
	player.add_energy = 0
	player.add_health = 0
	player.add_magic = 0
	set_text()
