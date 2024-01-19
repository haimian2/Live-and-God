extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tile_map:TileMap = get_tree().get_first_node_in_group("tile_map")
	if !tile_map:
		return
	var used := tile_map.get_used_rect()
	var tile_size := tile_map.tile_set.tile_size
	limit_top = used.position.y * tile_size.y
	limit_right = used.end.x * tile_size.x
	limit_bottom = used.end.y * tile_size.y
	limit_left = used.position.x * tile_size.x
	reset_smoothing()
