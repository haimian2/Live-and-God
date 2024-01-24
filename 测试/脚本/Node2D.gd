extends Node2D

@onready var tile_0085: Sprite2D = $Tile0085

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(tile_0085,"global_position",tile_0085.global_position + Vector2(0,-100),0.2)
	$AnimationPlayer.play("new_animation")	
	tween.tween_property(tile_0085,"global_position",tile_0085.global_position + Vector2(0,200),0.3)
