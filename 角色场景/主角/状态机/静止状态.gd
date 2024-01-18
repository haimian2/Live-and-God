extends Base_State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var delay_jump: Node = owner.get_node("Delay_jump/CoyoteTimer")

func enter():
	animated.stop()
	animated.play("静止")
	
func do():
	if !owner.is_on_floor():
		get_parent().change_state(6)
		return
	if Input.is_action_just_pressed("move_roll"):
		get_parent().change_state(5)
		return
	elif Input.is_action_just_pressed("move_jump"):
		get_parent().change_state(2)
		return
	elif Input.is_action_just_pressed("special_attack_u"):
		get_parent().change_state(10)
		return
	elif Input.is_action_just_pressed("move_attack"):
		get_parent().change_state(7)
		return
	var vec:Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("move_left","move_right")
	if vec.x != 0:
		get_parent().change_state(1)
		return
	owner.velocity = Vector2(0,1)
	var was_on_floor:bool = owner.is_on_floor()
	owner.move_and_slide()
	if owner.is_on_floor() != was_on_floor:
		delay_jump.start()
	else:
		delay_jump.stop()
