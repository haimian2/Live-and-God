extends CharacterBody2D
class_name BasicEnemy

const MAX_SPEED = 40

func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player()->Vector2:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player:
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
