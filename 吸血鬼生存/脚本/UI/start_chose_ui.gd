extends CanvasLayer

@onready var character_choose: CanvasLayer = $CharacterChoose
@onready var weapons_choose: CanvasLayer = $WeaponsChoose

func _ready() -> void:
	character_choose.visible = true
	character_choose.start_game_button_pressed.connect(on_start_game_button_pressed)
	weapons_choose.rechoose_character_button.connect(on_rechoose_character_button)
	
func on_start_game_button_pressed(texture:AtlasTexture,info:String,name:String):
	character_choose.visible = false
	weapons_choose.set_weapons_ui_visible(texture,info,name)

func on_rechoose_character_button():
	character_choose.visible = true
	weapons_choose.visible = false
