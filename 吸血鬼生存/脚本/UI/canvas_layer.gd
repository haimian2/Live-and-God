extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var character: Sprite2D = $MarginContainer/VBoxContainer/HBoxContainer/CharacterSprite/PanelContainer/Character
@onready var label: Label = $MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/CharacterInfo/PanelContainer/Label

func _ready() -> void:
	animation_player.play("人物运动")
	GameEvents.vampires_survived_character_selection.connect(on_vampires_survived_character_selection)
	
func on_vampires_survived_character_selection(sprite:AtlasTexture,text:String):
	character.texture = sprite
	label.text = text
