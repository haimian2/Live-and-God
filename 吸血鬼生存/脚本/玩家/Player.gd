extends CharacterBody2D

@export var game_over_ui:GameOverUI

const SPEED = 125
const ACCELERATION_SMOOTHING = 25

func _physics_process(delta: float) -> void:
	var x_move := Input.get_axis("move_left", "move_right")
	var y_move := Input.get_axis("move_up","move_down")
	var direction = Vector2(x_move,y_move).normalized()
	var target_velocity = direction * SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()
