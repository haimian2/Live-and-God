extends CharacterBody2D

signal player_attack(damage:int)

@onready var health_component: HealthComponent = $HealthComponent

const SPEED = 50

func _physics_process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * SPEED
	move_and_slide()

func get_direction_to_player()->Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO


