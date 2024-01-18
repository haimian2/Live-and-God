extends Base_State

@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var speed = owner.speed
@onready var floor_acceleration:float = owner.FLOOR_ACCELERATION
@onready var air_acceleration:float = owner.AIR_ACCELERATION
@onready var delay_jump: Node = owner.get_node("Delay_jump/CoyoteTimer")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter():
	animated.stop()
	animated.play("跑动")
	
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
	var acceleration:float = floor_acceleration if owner.is_on_floor() else air_acceleration
	vec.x = Input.get_axis("move_left","move_right")
	if vec.x == 0:
		get_parent().change_state(0)
		return
	elif vec.x > 0:
		animated.flip_h = false
		owner.get_node("Attack_Check").scale.x = 1
	else:
		animated.flip_h = true
		owner.get_node("Attack_Check").scale.x = -1		
	owner.velocity.x = move_toward(owner.velocity.x,vec.x * speed,acceleration * get_process_delta_time())
	owner.velocity.y += gravity * get_process_delta_time()
	var was_on_floor:bool = owner.is_on_floor()
	owner.move_and_slide()
	if owner.is_on_floor() != was_on_floor:
		delay_jump.start()
	else:
		delay_jump.stop()
