extends Base_State

@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var delay_jump: Node = owner.get_node("Delay_jump/CoyoteTimer")

var beenFall:bool = false

func enter():
	animated.play("下落")
	
func do():
	if owner.is_on_floor():
		beenFall = true
		animated.play("下落完成")
	elif delay_jump.time_left > 0 and Input.is_action_just_pressed("move_jump"):
		get_parent().change_state(2)
		delay_jump.stop()
	if !beenFall:
		var vec:Vector2 = Vector2.ZERO
		vec.x = Input.get_axis("move_left","move_right")
		if vec.x > 0:
			animated.flip_h = false
			owner.get_node("Attack_Check").scale.x = 1
		else:
			animated.flip_h = true
			owner.get_node("Attack_Check").scale.x = -1		
		owner.velocity.x = vec.x * owner.JUMP_MOVE_SPEED
		owner.velocity.y = owner.fall_speed
		owner.move_and_slide()



func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "下落完成":
		beenFall = false
		get_parent().change_state(0)
