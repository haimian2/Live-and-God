extends CharacterBody2D


const SPEED = 40.0
const JUMP_VELOCITY = -180.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var value:int = 100
var eated:bool = false

func _ready() -> void:
	velocity.y += JUMP_VELOCITY
	var ri = randi() % 2
	velocity.x += (randi() % 2 + 1) * SPEED if ri == 0 else (randi() % 2 - 2) * SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 0.5
	else:
		velocity.x = 0		
		for col in $Area2D.get_overlapping_bodies():
			if col.is_in_group("player"):
				if !eated:
					animation_player.play("吃")
					col.change_money.emit(value)
					visible = false
					eated = true
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
