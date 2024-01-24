@tool
extends PanelContainer

@export var sprite:AtlasTexture
@export_multiline var text:String
@onready var character: Sprite2D = $Character

func _ready() -> void:
	character.texture = sprite
	character.position = (size - character.get_rect().end * character.scale) / 2
	gui_input.connect(on_gui_input)
	
func on_gui_input(event:InputEvent):
	if event.is_action_pressed("mouse_left"):
		GameEvents.emit_vampires_survived_character_selection(sprite,text)
