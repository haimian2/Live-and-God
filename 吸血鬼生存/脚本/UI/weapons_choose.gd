extends CanvasLayer

signal choose_skill_button
signal rechoose_character_button

@onready var character_texture: TextureRect = %CharacterTexture
@onready var character_info: Label = %CharacterInfo
@onready var weapons_texture: TextureRect = %WeaponsTexture
@onready var weapons_info: Label = %WeaponsInfo
@onready var next_button: Button = %NextButton
@onready var preview_button: Button = %PreviewButton
@onready var go_on_button: Button = %GoOnButton
@onready var weapons_ui: GridContainer = %WeaponsUI

const WEAPONS_MANAGER = preload("res://吸血鬼生存/资源/武器/weapons_manager.tscn")
var weapons_array = WeaponsArray.new()
var selected_packed_scene:PackedScene = weapons_array.get_weapons_packed(0)

func _ready() -> void:
	next_button.pressed.connect(on_next_button_pressed)
	preview_button.pressed.connect(on_preview_button_pressed)
	for i in range(weapons_array.size()):
		var weapons = weapons_array.get_weapons(i)
		var panelcontainer = PanelContainer.new()
		panelcontainer.custom_minimum_size = Vector2(100,100)
		var margincontainer = MarginContainer.new()
		panelcontainer.add_child(margincontainer)
		var texturerect = TextureRect.new()
		texturerect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texturerect.texture = weapons.atlas
		margincontainer.add_child(texturerect)
		var label = Label.new()
		label.text = weapons.info
		label.visible = false
		texturerect.add_child(label)
		panelcontainer.gui_input.connect(on_weapons_ui_panelcontainer_gui_input.bind(weapons,panelcontainer))
		weapons_ui.add_child(panelcontainer)
	var weapons = weapons_array.get_weapons(0)
	weapons_texture.texture = weapons.atlas
	weapons_info.text = weapons.info

func set_weapons_ui_visible(texture:AtlasTexture,info:String,name:String):
	visible = true
	character_texture.texture = texture
	character_texture.scale = Vector2(20,20)
	character_info.text = info

func on_weapons_ui_panelcontainer_gui_input(event:InputEvent,weapons:Weapons,panelcontainer:PanelContainer):
	if event.is_action_pressed("mouse_left"):
		weapons_texture.texture = weapons.atlas
		weapons_info.text = weapons.info
		selected_packed_scene = weapons_array.get_weapons_packed(panelcontainer.get_index())

func on_next_button_pressed():
	var data:Dictionary = {}
	var weapons_manager = WEAPONS_MANAGER.instantiate()
	weapons_manager.weapons_scene = selected_packed_scene
	data["vampire_survival_init"] = {
		"character":character_texture.duplicate(),
		"weapons":weapons_texture.duplicate(),
		"skill":{
			"weapons_manager": weapons_manager
		}
	}
	SceneChanger.change_scene_data("res://吸血鬼生存/场景/vampire_survival_world.tscn",true,false,data,1)

func on_preview_button_pressed():
	rechoose_character_button.emit()
