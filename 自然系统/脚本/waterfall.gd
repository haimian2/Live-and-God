@tool
extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var waterfall: Sprite2D = $Waterfall

func _ready() -> void:
	#animation_player.play("waterfall")
	pass

func _process(delta):
	waterfall.material.set_shader_parameter("zoom", get_viewport_transform().y.y)

func _on_waterfall_item_rect_changed() -> void:
	waterfall.material.set_shader_parameter("scale", scale)
