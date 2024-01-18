extends Node

@onready var timer: Timer = $Timer

const MOUSE = preload("res://吸血鬼生存/场景/mouse.tscn")
const SPAWN_RADIUS = 400

func _ready() -> void:
	timer.wait_time = 3
	timer.timeout.connect(process_timeout)
	
func process_timeout()->void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy = MOUSE.instantiate() as Node2D
	$"../Enemies".add_child(enemy)
	enemy.global_position = spawn_position
