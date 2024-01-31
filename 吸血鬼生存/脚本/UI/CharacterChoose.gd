extends CanvasLayer

signal start_game_button_pressed(texture:AtlasTexture,info:String,name:String)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character_texture: TextureRect = %CharacterTexture
@onready var charater_name: Label = %CharaterName
@onready var character_info: Label = %CharacterInfo
@onready var character_ui: GridContainer = %CharacterUI
@onready var start_game: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Operate/PanelContainer/VBoxContainer/StartGame
@onready var go_on_game: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Operate/PanelContainer/VBoxContainer/GoOnGame
@onready var exit: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Operate/PanelContainer/VBoxContainer/Exit

var selected_atlas:AtlasTexture
var selected_info:String
var selected_name:String
var vampire_survival_characters = VampireSurvivalCharacterArray.new()

func _ready() -> void:
	animation_player.play("人物运动")
	GameEvents.vampires_survived_character_selection.connect(on_vampires_survived_character_selection)
	start_game.pressed.connect(on_start_game_pressed)
	go_on_game.pressed.connect(on_go_on_game_pressed)
	exit.pressed.connect(on_exit_pressed)
	character_texture.position = (%CharacterContainer.size - character_texture.custom_minimum_size) / 2
	for i in range(vampire_survival_characters.size()):
		var vsc = vampire_survival_characters.get_character(i)
		var panelcontainer = PanelContainer.new()
		panelcontainer.custom_minimum_size = Vector2(100,100)
		var margincontainer = MarginContainer.new()
		panelcontainer.add_child(margincontainer)
		var texturerect = TextureRect.new()
		texturerect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texturerect.texture = vsc.texture
		margincontainer.add_child(texturerect)
		var label = Label.new()
		label.text = vsc.info
		label.visible = false
		texturerect.add_child(label)
		panelcontainer.gui_input.connect(on_vampires_survived_character_selection.bind(vsc))
		character_ui.add_child(panelcontainer)
	var vampire_survival_character = vampire_survival_characters.get_character(0)
	character_texture.texture = vampire_survival_character.texture
	character_info.text = vampire_survival_character.info
	charater_name.text = vampire_survival_character.name
	selected_atlas = vampire_survival_character.texture
	selected_info = vampire_survival_character.info
	selected_name = vampire_survival_character.name

func on_vampires_survived_character_selection(event:InputEvent,vsc:VampireSurvivalCharacter):
	if event.is_action_pressed("mouse_left"):
		selected_atlas = vsc.texture
		selected_info = vsc.info
		selected_name = vsc.name
		character_texture.texture = vsc.texture
		character_info.text = vsc.info
		charater_name.text = vsc.name
		character_texture.position = (%CharacterContainer.size - character_texture.custom_minimum_size) / 2

func on_start_game_pressed():
	start_game_button_pressed.emit(selected_atlas,selected_info,selected_name)
	
func on_go_on_game_pressed():
	pass
	
func on_exit_pressed():
	SceneChanger.change_scene("res://地图/场景/地图二.tscn",true,false)
