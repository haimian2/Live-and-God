extends Node2D


@onready var tile_map: TileMap = $TileMap
@onready var camera_2d: Camera2D = $"Player/Camera2D"
@onready var player: CharacterBody2D = $Player
@onready var shop: StaticBody2D = $Shop

func _ready() -> void:
	var used := tile_map.get_used_rect()
	var tile_size := tile_map.tile_set.tile_size
	camera_2d.limit_top = used.position.y * tile_size.y
	camera_2d.limit_right = used.end.x * tile_size.x
	camera_2d.limit_bottom = used.end.y * tile_size.y
	camera_2d.limit_left = used.position.x * tile_size.x
	camera_2d.reset_smoothing()
	#thunder_rainy_day.set_rainy_day(used.position * tile_size,used.end * tile_size)
	#thunder_rainy_day.flash_position(used.position * tile_size,used.end * tile_size)
