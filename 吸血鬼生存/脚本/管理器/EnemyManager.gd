extends Node

@onready var timer: Timer = $Timer
@export var mouse_enemy:PackedScene
@export var arena_time_manager:ArenaTimeManager
const SPAWN_RADIUS = 500
var weighted_table = WeightTable.new()
var base_time:float = 2
var denominator:float = 10

func _ready() -> void:
	timer.wait_time = base_time
	timer.timeout.connect(process_timeout)
	arena_time_manager.update_difficulty.connect(on_update_difficulty)	
	weighted_table.add_item(mouse_enemy,10)
	
func get_spawn_position()->Vector2:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return Vector2.ZERO
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = Vector2.ZERO
		
	for i in 4:	
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		
		var query_paramters = PhysicsRayQueryParameters2D.create(player.global_position,spawn_position,1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramters)
		
		if result.is_empty():
			return spawn_position
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	return spawn_position
	
func process_timeout()->void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	
	var enemy_scene = weighted_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()
	
func on_update_difficulty(difficulty:float):
	timer.wait_time = base_time * (1 - difficulty / denominator)
